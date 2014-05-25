require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  def index
  end

  def backup
    @photos = Photo.order_by(:upload_time.desc).limit(20)
    set_variables
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  def tag
    photo = Photo.find params[:id]
    photo.add_tag params[:tag]
    render_json status: 'ok'
  end

  def tag_person
    photo = Photo.find params[:id]
    photo.add_person params[:tag]
    render_json status: 'ok'
  end

  def tag_place
    photo = Photo.find params[:id]
    photo.add_place params[:tag]
    render_json status: 'ok'
  end

  def photo
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.photo_path photo.filename
  end

  def delete
    photo = Photo.find params[:id]
    store = PhotoDiskStore.new
    FileUtils.rm [store.photo_path(photo.filename), store.sm_thumb_path(photo.filename), store.md_thumb_path(photo.filename)]
    photo.delete
    render :text => 'deleted'
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
    exif = @photo.exif PhotoDiskStore.new
    unless exif.nil?
      @resolution = "#{exif.width} x #{exif.height}"
      unless exif.exif.nil?
        @extra_exif = exif.exif.inspect
        @resolution << ' +'
      end
    end
    @tags = Photo.distinct(:tags) - @photo.tags
  end

end
