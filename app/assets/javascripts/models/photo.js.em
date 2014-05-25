# for more details see: http://emberjs.com/guides/models/defining-models/

class JpgRanger.Photo extends DS.Model
  originalFilename: DS.attr 'string'
  uploader: DS.attr 'string'
  photoTime: DS.attr 'date'
  tags: DS.attr()
  people: DS.attr()
  places: DS.attr()

  small_photo_path: (->
    "/small_thumb/#{@get('id')}"
  ).property('id')