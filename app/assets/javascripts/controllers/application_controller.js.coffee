JpgRanger.ApplicationController = Ember.Controller.extend
  master_tags_list: []
  master_places_list: []
  master_people_list: []
  master_collection_list: []
  uploads_pending: 0

  init: ->
    $.ajax('/globals', dataType: 'json', cache: false).done (data) =>
      @master_tags_list.pushObjects data.tags
      @master_places_list.pushObjects data.places
      @master_people_list.pushObjects data.people
      @master_collection_list.pushObjects data.collections

  has_uploads_pending: (->
    @get('uploads_pending')
  ).property('uploads_pending')
