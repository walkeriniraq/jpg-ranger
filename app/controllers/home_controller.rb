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
