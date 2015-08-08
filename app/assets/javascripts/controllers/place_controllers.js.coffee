JpgRanger.PlacePageController = JpgRanger.PhotoPagingController.extend
  needs: 'place'
  title: (->
    @get('controllers.place.model.place')
  ).property('controllers.place.model.place')
  photo_upload_data: (->
    { place: @get('controllers.place.model.place') }
  ).property('controllers.place.model.place')

JpgRanger.PlacePreviewController = JpgRanger.PhotoPreviewController.extend()
