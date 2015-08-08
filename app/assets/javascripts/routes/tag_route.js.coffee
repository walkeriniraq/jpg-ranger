JpgRanger.TagRoute = Ember.Route.extend
  model: (params) ->
    { tag: params.tag_name }

JpgRanger.TagIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'tag.page', params.tag, 1

JpgRanger.TagPageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page, tag: @modelFor('tag').tag }
  actions:
    change_page: (page) ->
      @transitionTo 'tag.page', @modelFor('tag').tag, page
    open_preview: (photo) ->
      @transitionTo 'tag.preview', @modelFor('tag').tag, photo
    file_uploaded: ->
      @transitionTo 'tag.page', @modelFor('tag').tag, 1
      @refresh()

JpgRanger.TagPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('tag.full', @modelFor('tag').tag, photo.id)
    previous: (photo) ->
      photo.previous_photo({tag: @modelFor('tag').tag}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('tag.preview', @modelFor('tag').tag, previous_photo)
    next: (photo) ->
      photo.next_photo({tag: @modelFor('tag').tag}).done (next_photo) =>
        if next_photo?
          @transitionTo('tag.preview', @modelFor('tag').tag, next_photo)

JpgRanger.TagFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({tag: @modelFor('tag').tag}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('tag.full', @modelFor('tag').tag, previous_photo)
    next: (photo) ->
      photo.next_photo({tag: @modelFor('tag').tag}).done (next_photo) =>
        if next_photo?
          @transitionTo('tag.full', @modelFor('tag').tag, next_photo)

