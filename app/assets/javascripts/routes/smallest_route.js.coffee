JpgRanger.SmallestIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'smallest.page', 1

JpgRanger.SmallestPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', { page: params.page, by_size: true }

  actions:
    change_page: (page) ->
      @transitionTo 'smallest.page', page
    open_preview: (photo) ->
      @transitionTo 'smallest.preview', photo
    file_uploaded: ->
      @transitionTo 'smallest.page', 1
      @refresh()

JpgRanger.SmallestPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.SmallestFullRoute = JpgRanger.BasePhotoRoute.extend()
