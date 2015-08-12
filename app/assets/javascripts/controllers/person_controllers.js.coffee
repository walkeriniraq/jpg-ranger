JpgRanger.PersonPageController = JpgRanger.PhotoPagingController.extend
  person: Ember.inject.controller()

  title: (->
    @get('person.model.person')
  ).property('person.model.person')
  photo_upload_data: (->
    { person: @get('person.model.person') }
  ).property('person.model.person')

JpgRanger.PersonPreviewController = JpgRanger.PhotoPreviewController.extend
  person: Ember.inject.controller()

  route_base_name: 'person'
  query_params: Ember.computed('person.model.person', -> { person: @get('person.model.person') })

JpgRanger.PersonFullController = JpgRanger.PhotoFullController.extend
  person: Ember.inject.controller()

  route_base_name: 'person'
  query_params: Ember.computed('person.model.person', -> { person: @get('person.model.person') })
 