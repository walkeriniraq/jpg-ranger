# for more details see: http://emberjs.com/guides/models/defining-models/

class JpgRanger.Photo extends DS.Model
  originalFilename: DS.attr 'string'
  uploader: DS.attr 'string'
  photoTime: DS.attr 'date'
  tags: DS.attr()
  people: DS.attr()
  places: DS.attr()

  small_photo_path: ~> "/photos/#{@id}/small_thumb"

  medium_photo_path: ~> "/photos/#{@id}/medium_thumb"

  momentPhotoTime: ~> moment @photoTime

  prettyPhotoTime: ~> return @momentPhotoTime.fromNow() if @momentPhotoTime.isValid()

  formattedPhotoTime: ~> return @momentPhotoTime.format("dddd MMMM Do YYYY - h:mm a") if @momentPhotoTime.isValid()
