class PhotosController < ApplicationController

  PAGE_SIZE = 36.0

  respond_to :json

  def index # find all
    query = query_from_params
    total_pages = (query.count / PAGE_SIZE).ceil
    page = (params[:page] || 1).to_i
    page = total_pages if page > total_pages
    start = [(page - 1) * PAGE_SIZE - 1, 0].max
    limit = if start < 1
              PAGE_SIZE + 1
            else
              PAGE_SIZE + 2
            end
    results = query.skip(start).limit(limit).map { |x| x }
    results.unshift(nil) if start < 1
    results.push(nil) if page == total_pages
    respond_with photos: results.each_cons(3).map { |p, x, n| SinglePhotoRepresenter.new(x, p.andand.id.andand.to_s, n.andand.id.andand.to_s) }, meta: { total_pages: total_pages, page: page }
  end

  def query_from_params
    query = case params[:sort_by]
              when 'filename'
                Photo.asc(:filename)
              when 'tags'
                Photo.asc(:tags_count)
              when 'photo_size'
                Photo.asc(:pixels)
              else
                Photo
            end.desc(:upload_time)
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

  def next_ids
    query = query_from_params
    if query.last.id.to_s == params[:id]
      respond_with(prev: query.skip(query.count - 2).first.id.to_s) and return
    end
    if query.first.id.to_s == params[:id]
      respond_with(next: query.limit(2).map(:id).last.to_s) and return
    end
    query.map(:id).each_cons(3) do |p, x, n|
      respond_with(prev: p.to_s, next: n.to_s) and return if (x.to_s == params[:id])
    end
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
        ret[:photos].save
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