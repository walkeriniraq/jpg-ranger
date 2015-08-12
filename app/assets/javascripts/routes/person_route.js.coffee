JpgRanger.PersonRoute = Ember.Route.extend
  model: (params) ->
    {person: params.person_name}

JpgRanger.PersonIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'person.page', params.person, 1

JpgRanger.PersonPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', {page: params.page, person: @modelFor('person').person}
  actions:
    change_page: (page) ->
      @transitionTo 'person.page', @modelFor('person').person, page
    open_preview: (photo) ->
      @transitionTo 'person.preview', @modelFor('person').person, photo
    file_uploaded: ->
      @transitionTo 'person.page', @modelFor('person').person, 1
      @refresh()

JpgRanger.PersonPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.PersonFullRoute = JpgRanger.BasePhotoRoute.extend()
