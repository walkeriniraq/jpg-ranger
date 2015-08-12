JpgRanger.CollectionPageController = JpgRanger.PhotoPagingController.extend
  collection: Ember.inject.controller()

  title: (->
    @get('collection.model.collection')
  ).property('collection.model.collection')
  photo_upload_data: (->
    { collection: @get('collection.model.collection') }
  ).property('collection.model.collection')

JpgRanger.CollectionPreviewController = JpgRanger.PhotoPreviewController.extend
  collection: Ember.inject.controller()

  route_base_name: 'collection'
  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })

JpgRanger.CollectionFullController = JpgRanger.PhotoFullController.extend
  collection: Ember.inject.controller()

  route_base_name: 'collection'
  query_params: Ember.computed('collection.model.collection', -> { collection: @get('collection.model.collection') })
 