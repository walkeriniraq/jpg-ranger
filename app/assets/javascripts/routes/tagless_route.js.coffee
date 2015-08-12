JpgRanger.TaglessIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'tagless.page', 1

JpgRanger.TaglessPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query('photo', { page: params.page, sans_tags: true })

  actions:
    change_page: (page) ->
      @transitionTo 'tagless.page', page
    open_preview: (photo) ->
      @transitionTo 'tagless.preview', photo

JpgRanger.TaglessPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.TaglessFullRoute = JpgRanger.BasePhotoRoute.extend()