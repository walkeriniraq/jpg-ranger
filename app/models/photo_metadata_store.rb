class PhotoMetadataStore
  def get_by_hash(hash)
    Photo.where(file_hash: hash).first
  end
end