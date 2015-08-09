JpgRanger.PersonPageController = JpgRanger.PhotoPagingController.extend
  person: Ember.inject.controller()

  title: (->
    @get('person.model.person')
  ).property('person.model.person')
  photo_upload_data: (->
    { person: @get('person.model.person') }
  ).property('person.model.person')

JpgRanger.PersonPreviewController = JpgRanger.PhotoPreviewController.extend()
