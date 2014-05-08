require 'pathname'

class PhotoDiskStore
  def initialize
    # @root = Pathname.new('photo_storage')
    @root = Pathname.new(Rails.configuration.photo_store)
    @full = @root + 'full'
    @thumb = @root + 'thumb'
    @full.mkdir unless @full.exist?
    @thumb.mkdir unless @thumb.exist?
  end

  def photo_path(filename)
    (build_directory(@full, filename) + filename).to_s
  end

  def sm_thumb_path(filename)
    (build_directory(@thumb, filename) + ('sm_' + filename)).to_s
  end

  def md_thumb_path(filename)
    (build_directory(@thumb, filename) + ('md_' + filename)).to_s
  end

  def build_directory(root_path, filename)
    first = root_path + filename[0]
    first.mkdir unless first.exist?
    second = first + filename[1]
    second.mkdir unless second.exist?
    second
  end

end