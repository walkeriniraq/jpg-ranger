class PhotosController < ApplicationController

  respond_to :json

  def index
    # find all
    respond_with Photo.all
  end

  def show
    # find
    respond_with Photo.find(params[:id])
  end

  def update

  end

  def create

  end

  def destroy

  end

end