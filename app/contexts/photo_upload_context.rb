require 'digest'
require 'delegate'

class PhotoUploadContext

  attr_reader :status, :filename

  def initialize(file, metadata_store, disk_store)
    @upload_file = UploadedFileRole.new(file)
    @metadata_store = metadata_store
    @disk_store = DiskStoreRole.new(disk_store)
  end

  def call
    @status = 'file was not an allowed image type' and return unless @upload_file.photo_type?
    existing_photo = @metadata_store.get_by_hash(@upload_file.file_hash)
    unless existing_photo.nil?
      set_return 'duplicate file', existing_photo.filename
      return
    end
    photo = @disk_store.store(@upload_file)
    photo.save
    begin
      img = Magick::Image::read(@upload_file.tempfile.path).first
    rescue Java::JavaLang::NullPointerException
      # yeah, ImageMagick throws a NPE if the photo isn't a photo
      # TODO: log this error condition
      set_return 'file could not be opened', photo.filename
    end
    if @upload_file.extension == '.jpg' || @upload_file.extension == '.jpeg'
      exif = EXIFR::JPEG.new(@upload_file.tempfile)
      orientation = exif.orientation
      if orientation
        img = orientation.transform_rmagick(img)
      end
      photo.update_attributes(photo_time: exif.date_time) unless exif.date_time.nil?
    end
    img.resize_to_fit(150, 150).write @disk_store.sm_thumb_path(photo.filename)
    img.resize_to_fit(1000, 1000).write @disk_store.md_thumb_path(photo.filename)
    set_return 'ok', photo.filename
  rescue EXIFR::MalformedJPEG
      # TODO: log this error condition
    set_return 'file extension is jpg but was not a jpeg', photo.filename
  end

  def set_return(status, filename)
    @status = status
    @filename = filename
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