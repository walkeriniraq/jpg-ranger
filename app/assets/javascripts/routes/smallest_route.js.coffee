JpgRanger.SmallestIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'smallest.page', 1

JpgRanger.SmallestPageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page, by_size: true }

  actions:
    change_page: (page) ->
      @transitionTo 'smallest.page', page
    open_preview: (photo) ->
      @transitionTo 'smallest.preview', photo
    file_uploaded: ->
      @transitionTo 'smallest.page', 1
      @refresh()

JpgRanger.SmallestPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('smallest.full', photo)
    previous: (photo) ->
      photo.previous_photo({ by_size: true }).done (previous_photo) =>
        if previous_photo?
          @transitionTo('smallest.preview', previous_photo)
    next: (photo) ->
      photo.next_photo({ by_size: true }).done (next_photo) =>
        if next_photo?
          @transitionTo('smallest.preview', next_photo)

JpgRanger.SmallestFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({ by_size: true }).done (previous_photo) =>
        if previous_photo?
          @transitionTo('smallest.full', previous_photo)
    next: (photo) ->
      photo.next_photo({ by_size: true }).done (next_photo) =>
        if next_photo?
          @transitionTo('smallest.full', next_photo)

