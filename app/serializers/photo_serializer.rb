class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :original_filename, :uploader, :photo_time, :resolution, :tags, :people, :places, :collections, :file_hash

  def id
    object._id.to_s
  end

end
