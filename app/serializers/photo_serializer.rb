class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :original_filename, :uploader, :photo_time, :resolution, :tags, :people, :places, :collection, :file_hash

  def id
    object._id.to_s
  end

  def collection
    object.group
  end

end
