class PhotosController < ApplicationController

  respond_to :json

  def index # find all
    query = Photo.order_by(:upload_time.desc).limit(20)
    tag = params[:tag].andand.downcase.andand.strip
    unless tag.blank?
      query = query.where(:tags.in => [tag])
    end
    respond_with query
  end

  def show # find
    respond_with Photo.find(params[:id])
  end

  def update

  end

  def create

  end

  def destroy

  end

end