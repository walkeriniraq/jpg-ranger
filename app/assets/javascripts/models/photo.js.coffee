# for more details see: http://emberjs.com/guides/models/defining-models/

JpgRanger.Photo = DS.Model.extend
  original_filename: DS.attr 'string'
  uploader: DS.attr 'string'
  photo_time: DS.attr 'date'
  resolution: DS.attr 'string'
  tags: DS.attr()
  people: DS.attr()
  places: DS.attr()
  collections: DS.attr()
  file_hash: DS.attr 'string'

  small_photo_path: (-> 
    "/photos/#{@get('id')}/small_thumb"
  ).property('id')

  medium_photo_path: (-> 
    "/photos/#{@get('id')}/medium_thumb"
  ).property('id')

  full_photo_path: (-> 
    "/photos/#{@get('id')}/full"
  ).property('id')

  moment_photo_time: (->
    moment @get('photo_time')
  ).property('photo_time')

  pretty_photo_time: (->
    return @get('moment_photo_time').fromNow() if @get('moment_photo_time').isValid()
  ).property('moment_photo_time')

  formatted_photo_time: (->
    return @get('moment_photo_time').format("dddd MMMM Do YYYY - h:mm a") if @get('moment_photo_time').isValid()
  ).property('moment_photo_time')

  next_photo: (params) ->
    $.getJSON("/photos/#{@get('id')}/next", params).then (data) =>
      if data.photo?
        @store.push('photo', @store.normalize('photo', data.photo))
      else
        null

  previous_photo: (params) ->
    $.getJSON("/photos/#{@get('id')}/previous", params).then (data) =>
      if data.photo?
        @store.push('photo', @store.normalize('photo', data.photo))
      else
        null

  delete: ->
    $.ajax(url: "/photos/#{@get('id')}", type: 'DELETE')