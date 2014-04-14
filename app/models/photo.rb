class Photo
  include Mongoid::Document

  field :orig, as: :original_filename, type: String
  field :fn, as: :filename, type: String
  field :up, as: :uploader, type: String
  field :ut, as: :upload_time, type: Time
  field :pt, as: :photo_time, type: Time
  field :tags, type: Array
  field :fh, as: :file_hash, type: String

end