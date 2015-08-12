JpgRanger.TagRoute = Ember.Route.extend
  model: (params) ->
    { tag: params.tag_name }

JpgRanger.TagIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'tag.page', params.tag, 1

JpgRanger.TagPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', { page: params.page, tag: @modelFor('tag').tag }
  actions:
    change_page: (page) ->
      @transitionTo 'tag.page', @modelFor('tag').tag, page
    open_preview: (photo) ->
      @transitionTo 'tag.preview', @modelFor('tag').tag, photo
    file_uploaded: ->
      @transitionTo 'tag.page', @modelFor('tag').tag, 1
      @refresh()

JpgRanger.TagPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.TagFullRoute = JpgRanger.BasePhotoRoute.extend()
