class Photo
  include Mongoid::Document

  field :orig, as: :original_filename, type: String
  field :fn, as: :filename, type: String
  field :up, as: :uploader, type: String
  field :ut, as: :upload_time, type: Time
  field :pt, as: :photo_time, type: Time
  field :r, as: :resolution, type: String
  field :px, as: :pixels, type: Integer
  field :fh, as: :file_hash, type: String

  field :p, as: :people, type: Array
  field :pl, as: :places, type: Array
  field :tags, type: Array
  field :col, as: :collections, type: Array
  field :t_c, as: :tags_count, type: Integer

  COUNT_REDUCE_FUNCTION = '
        function(key, values) {
          return Array.sum(values);
        }
      '

  def tags
    self.tags = [] if super.nil?
    super
  end

  def tags=(tags)
    super(tags)
    update_tags_count
  end

  def self.tag_counts
    map = '
      function() {
        this.tags.forEach(function(tag) {
          emit(tag, 1);
        });
      }
    '
    all.map_reduce(map, COUNT_REDUCE_FUNCTION).out(inline: true)
  end

  def people
    self.people = [] if super.nil?
    super
  end

  def people=(people)
    super(people)
    update_tags_count
  end

  def self.people_counts
    map = '
      function() {
        this.p.forEach(function(person) {
          emit(person, 1);
        });
      }
    '
    all.map_reduce(map, COUNT_REDUCE_FUNCTION).out(inline: true)
  end

  def places
    self.places = [] if super.nil?
    super
  end

  def places=(places)
    super(places)
    update_tags_count
  end

  def self.place_counts
    map = '
      function() {
        this.pl.forEach(function(place) {
          emit(place, 1);
        });
      }
    '
    all.map_reduce(map, COUNT_REDUCE_FUNCTION).out(inline: true)
  end

  def collections
    self.collections = [] if super.nil?
    super
  end

  def collections=(collections)
    super(collections)
    update_tags_count
  end

  def self.collection_counts
    map = '
      function() {
        this.col.forEach(function(collection) {
          emit(collection, 1);
        });
      }
    '
    all.map_reduce(map, COUNT_REDUCE_FUNCTION).out(inline: true)
  end

  def update_tags_count
    self.tags_count = people.size + places.size + tags.size + collections.size
  end

  def add_tag(tag)
    tag = tag.downcase.strip
    unless tags.include? tag
      tags << tag
      update_tags_count
      save
    end
  end

  def add_person(name)
    self.people ||= []
    name = name.downcase.strip
    unless people.include? name
      people << name
      update_tags_count
      save
    end
  end

  def add_place(name)
    self.places ||= []
    name = name.downcase.strip
    unless places.include? name
      self.places << name
      update_tags_count
      save
    end
  end

  def add_collection(name)
    self.collections ||= []
    name = name.downcase.strip
    unless collections.include? name
      collections << name
      update_tags_count
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