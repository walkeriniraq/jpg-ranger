class PhotosController < ApplicationController

  respond_to :json

  def index # find all
    page = (params[:page] || 1).to_i
    query = query_from_params
    paged_query = query.paginate(page: page, per_page: 36)
    if(page > paged_query.total_pages)
      page = paged_query.total_pages
      paged_query = query.paginate(page: page, per_page: 36)
    end
    respond_with paged_query, meta: { total_pages: paged_query.total_pages, page: page }
  end

  def query_from_params
    query = case params[:sort_by]
              when 'sans_tags'
                Photo.asc(:tags_count).desc(:upload_time)
              when 'photo_size'
                Photo.asc(:pixels).desc(:upload_time)
              else
                Photo.desc(:upload_time)
            end
    search_term = params[:search_term].andand.downcase.andand.strip
    unless search_term.blank?
      query = query.where(original_filename: /#{search_term}/)
    end
    people = params[:people].andand.map { |x| x.downcase.strip }.andand.reject { |x| x.blank? }
    query = query.and(:people.in => people) unless people.nil? or people.empty?
    places = params[:places].andand.map { |x| x.downcase.strip }.andand.reject { |x| x.blank? }
    query = query.and(:places.in => places) unless places.nil? or places.empty?
    tags = params[:tags].andand.map { |x| x.downcase.strip }.andand.reject { |x| x.blank? }
    query = query.and(:tags.in => tags) unless tags.nil? or tags.empty?
    group = params[:collections].andand.map { |x| x.downcase.strip }.andand.reject { |x| x.blank? }
    query = query.and(:group.in => group) unless group.nil? or group.empty?
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
    photo.update_attributes params.require(:photo).permit(:collection, tags: [], places: [], people: []).tap { |x| x[:group] = x.delete(:collection); x }
    respond_with photo
  end

  def create
    return render_json status: 'Must provide photos to upload.' if params[:files].blank?
    return render_json status: 'Must upload to a collection.' if params[:collection].blank?
    files = params[:files].map do |file|
      context = PhotoUploadContext.new(file, PhotoMetadataStore.new, PhotoDiskStore.new)
      ret = context.call
      if ret[:photos].nil?
        { status: ret[:status] }
      else
        ret[:photos].add_person params[:person] unless params[:person].nil?
        ret[:photos].add_place params[:place] unless params[:place].nil?
        ret[:photos].add_tag params[:tag] unless params[:tag].nil?
        ret[:photos].group = params[:collection]
        { status: ret[:status], id: ret[:photos].id }
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
    FileUtils.rm_f [store.photo_path(photo.filename), store.sm_thumb_path(photo.filename), store.md_thumb_path(photo.filename)]
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

  def multi_person_add
    Photo.find(params[:photos]).each do |photo|
      photo.add_person params[:person]
    end
    render_json status: 'ok'
  end

  def multi_place_add
    Photo.find(params[:photos]).each do |photo|
      photo.add_place params[:place]
    end
    render_json status: 'ok'
  end

  def multi_tag_add
    Photo.find(params[:photos]).each do |photo|
      photo.add_tag params[:tag]
    end
    render_json status: 'ok'
  end

  def multi_collection_add
    # TODO: multi-update
    Photo.find(params[:photos]).each do |photo|
      photo.group = params[:collection]
      photo.save
    end
    render_json status: 'ok'
  end

end