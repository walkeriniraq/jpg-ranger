require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  PUBLIC_PATH = Pathname.new('public')
  PHOTO_STORAGE_PATH = PUBLIC_PATH + 'photo_storage'

  def index
    @photos = Photo.page(1)
    @tags = Photo.distinct(:tags)
  end

  def tag
    photo = Photo.where(filename: params[:filename]).first
    photo.tags << params[:tag]
    photo.save
    render_json status: 'ok'
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
    photo = store_photo(file, file_hash)
    begin
      img = Magick::Image::read(PHOTO_STORAGE_PATH + photo.filename).first
    rescue Java::JavaLang::NullPointerException
      # yeah, ImageMagick throws a NPE if the photo isn't a photo
      return { status: 'file was not an image file or corrupt', filename: file.original_filename }
    end
    if ext == '.jpg' || ext == '.jpeg'
      exif = EXIFR::JPEG.new(file.tempfile)
      orientation = exif.orientation
      if orientation
        img = orientation.transform_rmagick(img)
      end
      photo.update_attributes(photo_time: exif.date_time) unless exif.date_time.nil?
    end
    img.resize_to_fit(150, 150).write((PUBLIC_PATH + photo.small_thumb).to_s)
    img.resize_to_fit(1000, 1000).write((PUBLIC_PATH + photo.medium_thumb).to_s)
    { status: 'ok', filename: photo.filename }
  rescue EXIFR::MalformedJPEG
    return { status: 'file extension is jpg but was not a jpeg', filename: file.original_filename }
  end

  def store_photo(file, file_hash)
    new_filename = SecureRandom.uuid.to_s + Pathname.new(file.original_filename).extname.downcase
    FileUtils.copy(file.tempfile, PHOTO_STORAGE_PATH + new_filename)
    Pathname.new(PHOTO_STORAGE_PATH + new_filename).chmod(0664)
    photo = Photo.new original_filename: file.original_filename,
                      filename: new_filename,
                      uploader: 'Nathan',
                      upload_time: Time.now,
                      tags: [],
                      file_hash: file_hash
    photo.save
    photo
  end

end
