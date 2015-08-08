JpgRanger.CollectionPageController = JpgRanger.PhotoPagingController.extend
  needs: 'collection'
  title: (->
    @get('controllers.collection.model.collection')
  ).property('controllers.collection.model.collection')
  photo_upload_data: (->
    { collection: @get('controllers.collection.model.collection') }
  ).property('controllers.collection.model.collection')

JpgRanger.CollectionPreviewController = JpgRanger.PhotoPreviewController.extend
