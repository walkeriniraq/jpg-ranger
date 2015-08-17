JpgRanger.CollectionIndexController = Ember.Controller.extend
  actions:
    view_collection: (name) ->
      @transitionToRoute 'collection.view', name


JpgRanger.CollectionViewController = Ember.Controller.extend
  application: Ember.inject.controller()
  upload_data: Ember.computed 'model.name', ->
    { collection: @get('model.name') }
  actions:
    start_upload: ->
      @get('application').incrementProperty 'uploads_pending'
    end_upload: ->
      @get('application').decrementProperty 'uploads_pending'

#JpgRanger.PhotosCollectionListIndexController = Ember.Controller.extend()
##  collection: Ember.inject.controller()
##
##  title: (->
##    @get('collection.model.collection')
##  ).property('collection.model.collection')
##  photo_upload_data: (->
##    { collection: @get('collection.model.collection') }
##  ).property('collection.model.collection')
#
#JpgRanger.PhotosCollectionListPreviewController = Ember.Controller.extend()
##  collection: Ember.inject.controller()
##
##  route_base_name: 'collection'
##  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })
#
#JpgRanger.PhotosCollectionListFullController = Ember.Controller.extend()
##  collection: Ember.inject.controller()
##
##  route_base_name: 'collection'
##  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })
#