JpgRanger.PlacePageController = JpgRanger.PhotoPagingController.extend
  place: Ember.inject.controller()

  title: (->
    @get('place.model.place')
  ).property('place.model.place')
  photo_upload_data: (->
    { place: @get('place.model.place') }
  ).property('place.model.place')

JpgRanger.PlacePreviewController = JpgRanger.PhotoPreviewController.extend
  place: Ember.inject.controller()

  route_base_name: 'place'
  query_params: Ember.computed('place.model.place', -> { place: @get('place.model.place') })

JpgRanger.PlaceFullController = JpgRanger.PhotoFullController.extend
  place: Ember.inject.controller()

  route_base_name: 'place'
  query_params: Ember.computed('place.model.place', -> { place: @get('place.model.place') })

