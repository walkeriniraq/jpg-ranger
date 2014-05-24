class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_json(hash)
    render json: hash
  end

  def set_variables
    @tags = Photo.distinct(:tags)
    @people = Photo.distinct(:people)
    @places = Photo.distinct(:places)
  end

end
