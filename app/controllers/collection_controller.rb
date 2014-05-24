class CollectionController < ApplicationController

  def tag
    @tag = params[:tag].downcase.strip
    raise 'Missing tag!' if @tag.blank?
    @photos = Photo.where(:tags.in => [@tag]).order_by(:upload_time.desc).limit(20)
    set_variables
    @tags << @tag unless @tags.include? @tag
  end

  def person
    @person = params[:person].downcase.strip
    raise 'Missing tag!' if @person.blank?
    @photos = Photo.where(:people.in => [@person]).order_by(:upload_time.desc).limit(20)
    set_variables
    @people << @person unless @people.include? @person
  end

  def place
    @place = params[:place].downcase.strip
    raise 'Missing tag!' if @place.blank?
    @photos = Photo.where(:places.in => [@place]).order_by(:upload_time.desc).limit(20)
    set_variables
    @places << @place unless @places.include? @place
  end

end
