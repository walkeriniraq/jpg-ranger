JpgRanger.PersonPageController = JpgRanger.PhotoPagingController.extend
  needs: 'person'
  title: (->
    @get('controllers.person.model.person')
  ).property('controllers.person.model.person')
  photo_upload_data: (->
    { person: @get('controllers.person.model.person') }
  ).property('controllers.person.model.person')

JpgRanger.PersonPreviewController = JpgRanger.PhotoPreviewController.extend()
