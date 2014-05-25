class Photo
  include Mongoid::Document

  field :orig, as: :original_filename, type: String
  field :fn, as: :filename, type: String
  field :up, as: :uploader, type: String
  field :ut, as: :upload_time, type: Time
  field :pt, as: :photo_time, type: Time
  field :r, as: :resolution, type: String
  field :tags, type: Array
  field :p, as: :people, type: Array
  field :pl, as: :places, type: Array
  field :fh, as: :file_hash, type: String

  def add_tag(tag)
    tag = tag.downcase.strip
    unless tags.include? tag
      tags << tag
      save
    end
  end

  def add_person(name)
    self.people ||= []
    name = name.downcase.strip
    unless people.include? name
      people << name
      save
    end
  end

  def add_place(name)
    self.places ||= []
    name = name.downcase.strip
    unless places.include? name
      places << name
      save
    end
  end

  def extension
    @ext ||= Pathname.new(filename).extname[1..-1].downcase
  end

  def exif(disk_store)
    return EXIFR::JPEG.new(disk_store.photo_path filename) if (extension == 'jpg' || extension == 'jpeg')
  end

end