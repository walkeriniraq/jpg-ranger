JpgRanger.BaseController = Ember.Controller.extend
  application: Ember.inject.controller()

JpgRanger.PhotoPreviewController = JpgRanger.BaseController.extend
  computed_people_list: (->
    @get('application.master_people_list').toArray().removeObjects(@get('model.people') || []).sort()
  ).property('model.people.[]', 'application.master_people_list.[]', 'application.master_people_list')

  computed_places_list: (->
    @get('application.master_places_list').toArray().removeObjects(@get('model.places') || []).sort()
  ).property('model.places.[]', 'application.master_places_list.[]', 'application.master_places_list')

  computed_tags_list: (->
    @get('application.master_tags_list').toArray().removeObjects(@get('model.tags') || []).sort()
  ).property('model.tags.[]', 'application.master_tags_list.[]', 'application.master_tags_list')

  computed_collections_list: (->
    @get('application.master_collection_list').toArray().removeObjects(@get('model.collections') || []).sort()
  ).property('model.collections.[]', 'application.master_collection_list.[]', 'application.master_collection_list')

JpgRanger.PhotoPagingController = JpgRanger.BaseController.extend
  selected_photos: []

  actions:
    tagging_add_person: (person) ->
      @send 'add_person', @get('selected_photos'), person
    tagging_add_place: (place) ->
      @send 'add_place', @get('selected_photos'), place
    tagging_add_tag: (tag) ->
      @send 'add_tag', @get('selected_photos'), tag
#      JpgRanger.Photo.add_tag_multiple(tag, @get('selected_photos')).then =>
#        @send('reload')
    tagging_add_collection: (collection) ->
      @send 'add_collection', @get('selected_photos'), collection
#      JpgRanger.Photo.add_collection_multiple(collection, @get('selected_photos')).then =>
#        @send('reload')
