class PhotosController < ApplicationController

  respond_to :json

  def index # find all
    page = (params[:page] || 1).to_i
    query = query_from_params.paginate(page: page, per_page: 80)
    respond_with query, meta: { total_pages: query.total_pages, page: page }
  end

  def query_from_params
    query = if params[:sans_tags]
              Photo.where(:tags_count.lt => 4).asc(:tags_count)
            elsif params[:by_size]
              Photo.asc(:pixels)
            else
              Photo.desc(:upload_time)
            end
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
    collection = params[:collection].andand.downcase.andand.strip
    unless collection.blank?
      query = query.where(:collections.in => [collection])
    end
    query
  end

  def next
    query = query_from_params
    if query.last.id.to_s != params[:id]
      next_id = nil
      query.map(:_id).each_cons(2) { |x, x2| next_id = x2 if x.to_s == params[:id] }
      respond_with Photo.find(next_id) and return unless next_id.nil?
    end
    respond_with(data: 'end')
  end

  def previous
    query = query_from_params
    if query.first.id.to_s != params[:id]
      previous_id = nil
      query.map(:_id).each_cons(2) { |x, x2| previous_id = x if x2.to_s == params[:id] }
      respond_with Photo.find(previous_id) and return unless previous_id.nil?
    end
    respond_with(data: 'end')
  end

  def show # find
    respond_with Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])
    photo.update_attributes params.require(:photo).permit(tags: [], places: [], people: [], collections: [])
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
        ret[:photo].add_collection params[:collection] unless params[:collection].nil?
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