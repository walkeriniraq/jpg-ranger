class PhotosController < ApplicationController

  respond_to :json

  def index # find all
    query = Photo.order_by(:upload_time.desc).limit(20)
    tag = params[:tag].andand.downcase.andand.strip
    unless tag.blank?
      query = query.where(:tags.in => [tag])
    end
    place = params[:place].andand.downcase.andand.strip
    unless place.blank?
      query = query.where(:places.in => [place])
    end
    person = params[:person].andand.downcase.andand.strip
    unless person.blank?
      query = query.where(:people.in => [person])
    end
    respond_with query
  end

  def show # find
    respond_with Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])
    photo.update_attributes params.require(:photo).permit(tags: [], places: [], people: [])
    respond_with photo
  end

  def create
    return render_json status: 'Must provide photos to upload.' if params[:files].blank?
    files = params[:files].map do |file|
      context = PhotoUploadContext.new(file, PhotoMetadataStore.new, PhotoDiskStore.new)
      ret = context.call
      if ret[:photo].nil?
        { status: ret[:status] }
      else
        ret[:photo].add_person params[:person] unless params[:person].nil?
        ret[:photo].add_place params[:place] unless params[:place].nil?
        ret[:photo].add_tag params[:tag] unless params[:tag].nil?
        { status: ret[:status], id: ret[:photo].id }
      end
    end
    if browser.ie?
      render text: { status: 'ok', files: files }.to_json
    else
      render_json status: 'ok', files: files
    end
  end

  def destroy
    photo = Photo.find params[:id]
    store = PhotoDiskStore.new
    FileUtils.rm [store.photo_path(photo.filename), store.sm_thumb_path(photo.filename), store.md_thumb_path(photo.filename)]
    photo.delete
    render_json status: 'deleted'
  end

  def small_thumb
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.sm_thumb_path photo.filename
  end

  def medium_thumb
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.md_thumb_path photo.filename
  end

  def full
    photo = Photo.find params[:id]
    send_file PhotoDiskStore.new.photo_path photo.filename
  end

end