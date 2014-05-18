class Photo
  # WEB_PATH = Pathname.new 'thumb_storage'

  include Mongoid::Document

  field :orig, as: :original_filename, type: String
  field :fn, as: :filename, type: String
  field :up, as: :uploader, type: String
  field :ut, as: :upload_time, type: Time
  field :pt, as: :photo_time, type: Time
  field :tags, type: Array
  field :fh, as: :file_hash, type: String

  def add_tag(tag)
    tag = tag.downcase.strip
    tags << tag unless tags.include? tag
    save
  end

  # def small_thumb
  #   WEB_PATH + ('sm_' + filename.to_s)
  # end
  #
  # def medium_thumb
  #   WEB_PATH + ('md_' + filename.to_s)
  # end

end