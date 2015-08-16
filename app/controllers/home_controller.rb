require 'RMagick'
require 'pathname'

class HomeController < ApplicationController

  def index
  end

  def globals
    render_json people: Photo.distinct(:people), tags: Photo.distinct(:tags), places: Photo.distinct(:places), collections: Photo.distinct(:group).sort
  end

  def stats
    render_json tags: Photo.tag_counts,
                people: Photo.people_counts,
                places: Photo.place_counts,
                collections: Photo.collection_counts
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

  def tag_collection
    photo = Photo.find params[:id]
    photo.group = params[:tag]
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
