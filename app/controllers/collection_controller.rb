class CollectionController < ApplicationController

  def tag
    @tag = params[:tag].downcase.strip
    raise 'Missing tag!' if @tag.blank?
    @photos = Photo.where(:tags.in => [@tag]).order_by(:upload_time.desc).page(1)
    @tags = Photo.distinct(:tags)
    @tags << @tag unless @tags.include? @tag
  end

end
