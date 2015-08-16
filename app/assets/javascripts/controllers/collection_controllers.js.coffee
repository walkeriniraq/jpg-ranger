JpgRanger.PhotosCollectionIndexController = Ember.Controller.extend()

JpgRanger.PhotosCollectionListIndexController = Ember.Controller.extend()
#  collection: Ember.inject.controller()
#
#  title: (->
#    @get('collection.model.collection')
#  ).property('collection.model.collection')
#  photo_upload_data: (->
#    { collection: @get('collection.model.collection') }
#  ).property('collection.model.collection')

JpgRanger.PhotosCollectionListPreviewController = Ember.Controller.extend()
#  collection: Ember.inject.controller()
#
#  route_base_name: 'collection'
#  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })

JpgRanger.PhotosCollectionListFullController = Ember.Controller.extend()
#  collection: Ember.inject.controller()
#
#  route_base_name: 'collection'
#  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })
 