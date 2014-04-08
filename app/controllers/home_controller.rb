require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  PHOTO_STORAGE_PATH = 'public/photo_storage/'

  def index
    web_path = Pathname.new 'photo_storage'
    @photos = Pathname.new(PHOTO_STORAGE_PATH).entries.
        reject { |x| x.directory? || x.basename.to_s[0] == '.' }.
    map { |x| web_path + x }
  end

  def upload
    return render_json status: 'Must provide photos to upload.' if params[:files].blank?
    files = params[:files].map { |file| process_upload file, redis }
    # if browser.ie?
    #   render text: { status: 'ok', files: files }.to_json
    # else
      render_json status: 'ok', files: files
    # end
  end

  def process_upload(file, redis)
    ext = Pathname.new(file.original_filename).extname.downcase
    return { status: 'file was not an allowed image type', filename: file.original_filename } unless %w(.jpg .jpeg .png .gif).include? ext
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
      orientation = EXIFR::JPEG.new(PHOTO_STORAGE_PATH + new_filename).orientation
      if orientation
        img = orientation.transform_rmagick(img)
        # img.write('photo_storage/' + new_filename)
      end
    end
    img.resize_to_fit(150, 150).write(PHOTO_STORAGE_PATH + 'sm_' + new_filename)
    img.resize_to_fit(1000, 1000).write(PHOTO_STORAGE_PATH + 'md_' + new_filename)
    # metadata = PhotoMetadata.create current_username, file.original_filename, new_filename
    # redis.photo_metadata_store.save metadata, new_filename
    { status: 'ok', filename: new_filename }
  rescue EXIFR::MalformedJPEG
    return { status: 'file extension is jpg but was not a jpeg', filename: file.original_filename }
  end

end
