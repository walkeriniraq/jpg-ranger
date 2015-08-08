JpgRanger.TaglessIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'tagless.page', 1

JpgRanger.TaglessPageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page, sans_tags: true }

  actions:
    change_page: (page) ->
      @transitionTo 'tagless.page', page
    open_preview: (photo) ->
      @transitionTo 'tagless.preview', photo
    file_uploaded: ->
      @transitionTo 'tagless.page', 1
      @refresh()

JpgRanger.TaglessPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('tagless.full', photo)
    previous: (photo) ->
      photo.previous_photo({ sans_tags: true }).done (previous_photo) =>
        if previous_photo?
          @transitionTo('tagless.preview', previous_photo)
    next: (photo) ->
      photo.next_photo({ sans_tags: true }).done (next_photo) =>
        if next_photo?
          @transitionTo('tagless.preview', next_photo)
    delete: (photo) ->
      if (window.confirm("Are you sure?"))
        photo.delete().then =>
          @transitionTo('tagless.page', 1)

JpgRanger.TaglessFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({ sans_tags: true }).done (previous_photo) =>
        if previous_photo?
          @transitionTo('tagless.full', previous_photo)
    next: (photo) ->
      photo.next_photo({ sans_tags: true }).done (next_photo) =>
        if next_photo?
          @transitionTo('tagless.full', next_photo)
    back: (photo) ->
      @transitionTo('tagless.preview', photo)
