class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :original_filename, :uploader, :photo_time, :tags, :people, :places

  def id
    object._id.to_s
  end
end
