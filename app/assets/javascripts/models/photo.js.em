# for more details see: http://emberjs.com/guides/models/defining-models/

class JpgRanger.Photo extends DS.Model
  originalFilename: DS.attr 'string'
  uploader: DS.attr 'string'
  photoTime: DS.attr 'date'
  tags: DS.attr()
  people: DS.attr()
  places: DS.attr()

  small_photo_path: (->
    "/photos/#{@get('id')}/small_thumb"
  ).property('id')

  medium_photo_path: (->
    "/photos/#{@get('id')}/medium_thumb"
  ).property('id')

  momentPhotoTime: (->
    moment @get('photoTime')
  ).property 'photoTime'

  prettyPhotoTime: (->
    time = @get 'momentPhotoTime'
    return time.fromNow() if time.isValid()
  ).property 'momentPhotoTime'

  formattedPhotoTime: (->
    time = @get 'momentPhotoTime'
    return time.format("dddd MMMM Do YYYY - h:mm a") if time.isValid()
  ).property 'momentPhotoTime'