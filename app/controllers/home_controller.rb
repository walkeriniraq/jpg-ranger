require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  PHOTO_STORAGE_PATH = 'public/photo_storage/'
  THUMB_STORAGE_PATH = 'public/thumb_storage/'

  def index
    web_path = Pathname.new 'thumb_storage'
    # @photos = Pathname.new(PHOTO_STORAGE_PATH).entries.
    #     reject { |x| x.directory? || x.basename.to_s[0] == '.' }.
    # map { |x| web_path + ('sm_' + x.to_s) }
    @photos = Photo.page(1).map do |photo|
      web_path + ('sm_' + photo.filename.to_s)
    end
  end

  def upload
    return render_json status: 'Must provide photos to upload.' if params[:files].blank?
    files = params[:files].map { |file| process_upload file }
    # if browser.ie?
    #   render text: { status: 'ok', files: files }.to_json
    # else
    render_json status: 'ok', files: files
    # end
  end

  def process_upload(file)
    ext = Pathname.new(file.original_filename).extname.downcase
    return { status: 'file was not an allowed image type', filename: file.original_filename } unless %w(.jpg .jpeg .png .gif).include? ext
    file_hash = Digest::MD5.file(file.tempfile).hexdigest
    existing_photo = Photo.where(file_hash: file_hash)
    return { status: 'File has already been uploaded.', filename: existing_photo.first.filename } if existing_photo.count > 0
    new_filename = SecureRandom.uuid.to_s + ext
    FileUtils.copy(file.tempfile, PHOTO_STORAGE_PATH + new_filename)
    Pathname.new(PHOTO_STORAGE_PATH + new_filename).chmod(0664)
    begin
      img = Magick::Image::read(PHOTO_STORAGE_PATH + new_filename).first
    rescue Java::JavaLang::NullPointerException
      # yeah, ImageMagick throws a NPE if the photo isn't a photo
      return { status: 'file was not an image file or corrupt', filename: file.original_filename }
    end
    if ext == '.jpg' || ext == '.jpeg'
      exif = EXIFR::JPEG.new(PHOTO_STORAGE_PATH + new_filename)
      orientation = exif.orientation
      if orientation
        img = orientation.transform_rmagick(img)
      end
      photo_time = exif.date_time
    end
    img.resize_to_fit(150, 150).write(THUMB_STORAGE_PATH + 'sm_' + new_filename)
    img.resize_to_fit(1000, 1000).write(THUMB_STORAGE_PATH + 'md_' + new_filename)
    photo = Photo.new original_filename: file.original_filename,
                      filename: new_filename,
                      uploader: 'Nathan',
                      upload_time: Time.now,
                      tags: [],
                      file_hash: file_hash
    photo.photo_time = photo_time unless photo_time.nil?
    photo.save
    { status: 'ok', filename: new_filename }
  rescue EXIFR::MalformedJPEG
    return { status: 'file extension is jpg but was not a jpeg', filename: file.original_filename }
  end

end
