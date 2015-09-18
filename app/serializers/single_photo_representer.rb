require 'representable/json'

class SinglePhotoRepresenter < Representable::Decorator
  include Representable::JSON

  attr_accessor :next_photo_id, :prev_photo_id

  def initialize(photo, next_photo_id, prev_photo_id)
    @prev_photo_id = prev_photo_id
    @next_photo_id = next_photo_id
    super(photo)
  end

  property :id, exec_context: :decorator
  property :original_filename
  property :uploader
  property :photo_time
  property :resolution
  property :tags
  property :people
  property :places
  property :collection, exec_context: :decorator
  property :file_hash
  property :next_photo_id, exec_context: :decorator
  property :prev_photo_id, exec_context: :decorator

  def id
    represented._id.to_s
  end

  def collection
    represented.group
  end

end