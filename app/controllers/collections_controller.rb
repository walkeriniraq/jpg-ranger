class CollectionsController < ApplicationController
  def index
    groups = Photo.distinct(:group).sort.map do |group|
          query = Photo.where(group: group)
          {
              name: group,
              photo_count: query.count,
              tag_count: query.sum(:tags_count)
          }
        end
    render_json collections: groups
  end

  def show
    group = params[:id].andand.strip.andand.downcase
    render_json error: 'Must provide a collection to view' and return if group.blank?
    query = Photo.where(group: group)
    render_json collection: {
                    name: group,
                    photo_count: query.count,
                    tag_count: query.sum(:tags_count),
                    tags: query.tag_counts,
                    people: query.people_counts,
                    places: query.place_counts
                }
  end

end