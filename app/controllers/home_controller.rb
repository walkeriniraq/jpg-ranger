require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  def index
    @photos = Photo.order_by(:upload_time.desc).page(1)
    @tags = Photo.distinct(:tags)
  end

  def tag
    tag = params[:tag].downcase.strip
    render_json status: 'missing tag!' and return if tag.blank?
    photo = Photo.where(filename: params[:filename]).first
    photo.tags << tag unless photo.tags.include? tag
    photo.save
    render_json status: 'ok'
  end

  def upload
    return render_json status: 'Must provide photos to upload.' if params[:files].blank?
    files = params[:files].map do |file|
      context = PhotoUploadContext.new(file, PhotoMetadataStore.new, PhotoDiskStore.new)
      context.call
      { status: context.status, filename: context.filename }
      # process_upload file
    end
    if browser.ie?
      render text: { status: 'ok', files: files }.to_json
    else
      render_json status: 'ok', files: files
    end
  end

  def photo
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.photo_path photo.filename
  end

  def small_thumb
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.sm_thumb_path photo.filename
  end

  def medium_thumb
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.md_thumb_path(photo.filename), disposition: 'inline'
  end

  def preview
    @photo = Photo.find params[:id]
  end

end
