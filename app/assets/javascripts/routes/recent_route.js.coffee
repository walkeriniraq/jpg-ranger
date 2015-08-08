JpgRanger.RecentIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'recent.page', 1

JpgRanger.RecentPageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page }

  actions:
    change_page: (page) ->
      @transitionTo 'recent.page', page
    open_preview: (photo) ->
      @transitionTo 'recent.preview', photo
    file_uploaded: ->
      @transitionTo 'recent.page', 1
      @refresh()

JpgRanger.RecentPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('recent.full', photo)
    previous: (photo) ->
      photo.previous_photo().done (previous_photo) =>
        if previous_photo?
          @transitionTo('recent.preview', previous_photo)
    next: (photo) ->
      photo.next_photo().done (next_photo) =>
        if next_photo?
          @transitionTo('recent.preview', next_photo)
    delete: (photo) ->
      if (window.confirm("Are you sure?"))
        photo.delete().then =>
          @transitionTo('recent.page', 1)

JpgRanger.RecentFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo().done (previous_photo) =>
        if previous_photo?
          @transitionTo('recent.full', previous_photo)
    next: (photo) ->
      photo.next_photo().done (next_photo) =>
        if next_photo?
          @transitionTo('recent.full', next_photo)

