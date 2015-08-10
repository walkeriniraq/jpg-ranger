JpgRanger.CollectionPageController = JpgRanger.PhotoPagingController.extend
  collection: Ember.inject.controller()

  title: (->
    @get('collection.model.collection')
  ).property('collection.model.collection')
  photo_upload_data: (->
    { collection: @get('collection.model.collection') }
  ).property('collection.model.collection')

JpgRanger.CollectionPreviewController = JpgRanger.PhotoPreviewController.extend()
