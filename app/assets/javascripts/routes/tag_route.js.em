class JpgRanger.TagRoute extends Ember.Route
  model: (params) ->
    { tag: params.tag_name }

class JpgRanger.TagIndexRoute extends Ember.Route
  redirect: (params) ->
    @transitionTo 'tag.page', params.tag, 1

class JpgRanger.TagPageRoute extends JpgRanger*.BasePhotoPagingRoute
  setupController: (controller, model) ->
    super(controller, model)
    tag = @parent_model().tag
    controller.title = tag
    controller.preview_route = 'tag.preview'
    controller.photo_upload_data = { tag: tag }

  actions:
    change_page: (page) ->
      @transitionTo 'tag.page', @parent_model().tag, page
    file_uploaded: ->
      @transitionTo 'tag.page', 1
      @refresh()

class JpgRanger.TagPreviewRoute extends JpgRanger*.BasePhotoPreviewRoute
  actions:
    open_full: (photo) ->
      @transitionTo('tag.full', @parent_model().tag, photo.id)

class JpgRanger.TagFullRoute extends JpgRanger*.BasePhotoFullRoute
