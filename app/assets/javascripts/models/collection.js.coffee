JpgRanger.Collection = Ember.Object.extend
  name: null
  photo_count: null
  tag_count: null
  tags: null
  people: null
  places: null

  pretty_name: Ember.computed 'name', ->
    @get('name').capitalize()

  average_tags: Ember.computed 'photo_count', 'tag_count', ->
    (@get('tag_count') / @get('photo_count')).toFixed(1)

JpgRanger.Collection.reopenClass
  list: ->
    $.getJSON('/collections').then (data) =>
      Ember.A(@create(collection)) for collection in data.collections

  get: (name) ->
    $.getJSON('/collections/' + name).then (data) =>
      @create(data.collection)

