# for more details see: http://emberjs.com/guides/models/defining-models/

class JpgRanger.Photo extends DS.Model
  original_filename: DS.attr 'string'
  uploader: DS.attr 'string'
  photo_time: DS.attr 'date'
  resolution: DS.attr 'string'
  tags: DS.attr()
  people: DS.attr()
  places: DS.attr()
  file_hash: DS.attr 'string'

  small_photo_path: ~> "/photos/#{@id}/small_thumb"

  medium_photo_path: ~> "/photos/#{@id}/medium_thumb"

  medium_photo_background_url: ~> "background: url('#{@medium_photo_path}')"

  moment_photo_time: ~> moment @photo_time

  pretty_photo_time: ~> return @moment_photo_time.fromNow() if @moment_photo_time.isValid()

  formatted_photo_time: ~> return @moment_photo_time.format("dddd MMMM Do YYYY - h:mm a") if @moment_photo_time.isValid()
