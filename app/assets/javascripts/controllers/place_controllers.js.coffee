JpgRanger.PlacePageController = JpgRanger.PhotoPagingController.extend
  place: Ember.inject.controller()

  title: (->
    @get('place.model.place')
  ).property('place.model.place')
  photo_upload_data: (->
    { place: @get('place.model.place') }
  ).property('place.model.place')

JpgRanger.PlacePreviewController = JpgRanger.PhotoPreviewController.extend()
