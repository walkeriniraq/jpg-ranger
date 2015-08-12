JpgRanger.RecentIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'recent.page', 1

JpgRanger.RecentPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', { page: params.page }

  actions:
    change_page: (page) ->
      @transitionTo 'recent.page', page
    open_preview: (photo) ->
      @transitionTo 'recent.preview', photo
    file_uploaded: ->
      @transitionTo 'recent.page', 1
      @refresh()

JpgRanger.RecentPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.RecentFullRoute = JpgRanger.BasePhotoRoute.extend()
