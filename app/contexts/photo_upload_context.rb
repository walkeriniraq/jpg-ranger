require 'digest'
require 'delegate'

class PhotoUploadContext

  def initialize(file, metadata_store, disk_store)
    @upload_file = UploadedFileRole.new(file)
    @metadata_store = metadata_store
    @disk_store = DiskStoreRole.new(disk_store)
  end

  def call
    return { status: 'file was not an allowed image type' } unless @upload_file.photo_type?
    existing_photo = @metadata_store.get_by_hash(@upload_file.file_hash)
    return { status: 'duplicate file', photo: existing_photo } unless existing_photo.nil?

    photo = @disk_store.store(@upload_file)
    photo.save
    begin
      img = Magick::Image::read(@upload_file.tempfile.path).first
    rescue Java::JavaLang::NullPointerException
      # yeah, ImageMagick throws a NPE if the photo isn't a photo
      # TODO: log this error condition
      return { status: 'file could not be opened' }
    end
    if @upload_file.extension == 'jpg' || @upload_file.extension == 'jpeg'
      exif = EXIFR::JPEG.new(@upload_file.tempfile)
      orientation = exif.orientation
      if orientation
        img = orientation.transform_rmagick(img)
      end
      attr = { resolution: "#{exif.width} x #{exif.height}" }
      photo_time = exif.andand.date_time || exif.andand.exif.andand.andand.date_time_original
      attr[:photo_time] = photo_time unless photo_time.nil?
      photo.update_attributes(attr)
    end
    img.resize_to_fit(150, 150).write "tmp/#{photo.filename}"
    FileUtils.move "tmp/#{photo.filename}", @disk_store.sm_thumb_path(photo.filename)
    img.resize_to_fit(600, 800).write "tmp/#{photo.filename}"
    FileUtils.move "tmp/#{photo.filename}", @disk_store.md_thumb_path(photo.filename)
    { status: 'ok', photo: photo }
  rescue EXIFR::MalformedJPEG
    # TODO: log this error condition
    'file extension is jpg but was not a jpeg'
  end

  class DiskStoreRole < SimpleDelegator
    def store(file)
      new_filename = SecureRandom.uuid.to_s + Pathname.new(file.filename).extname.downcase
      photo = Photo.new original_filename: file.filename,
                        filename: new_filename,
                        #  TODO: fix uploader
                        uploader: 'Nathan',
                        upload_time: Time.now,
                        tags: [],
                        file_hash: file.file_hash
      FileUtils.copy file.tempfile, photo_path(photo.filename)
      # Pathname.new(PHOTO_STORAGE_PATH + new_filename).chmod(0664)
      photo
    end
  end

  class UploadedFileRole
    PHOTO_EXTENSIONS = %w(jpg jpeg gif png).freeze

    def initialize(file)
      @file = file
    end

    def extension
      @ext ||= Pathname.new(@file.original_filename).extname[1..-1].downcase
    end

    def photo_type?
      return true if PHOTO_EXTENSIONS.include?(extension)
      false
    end

    def tempfile
      @file.tempfile
    end

    def file_hash
      @hash ||= Digest::MD5.file(@file.tempfile).hexdigest
    end

    def filename
      @file.original_filename
    end
  end

end