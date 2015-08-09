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

JpgRanger.PersonPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('person.full', @modelFor('person').person, photo.id)
    previous: (photo) ->
      photo.previous_photo({person: @modelFor('person').person}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('person.preview', @modelFor('person').person, previous_photo)
    next: (photo) ->
      photo.next_photo({person: @modelFor('person').person}).done (next_photo) =>
        if next_photo?
          @transitionTo('person.preview', @modelFor('person').person, next_photo)
    delete: (photo) ->
      if (window.confirm("Are you sure?"))
        photo.delete().then =>
          @transitionTo('person.page', @modelFor('person').person, 1)

JpgRanger.PersonFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({person: @modelFor('person').person}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('person.full', @modelFor('person').person, previous_photo)
    next: (photo) ->
      photo.next_photo({person: @modelFor('person').person}).done (next_photo) =>
        if next_photo?
          @transitionTo('person.full', @modelFor('person').person, next_photo)

