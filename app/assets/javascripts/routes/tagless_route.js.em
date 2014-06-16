class JpgRanger.TaglessRoute extends Ember.Route
  model: ->
    { sans_tags: true }

class JpgRanger.TaglessIndexRoute extends Ember.Route
  redirect: ->
    @transitionTo 'tagless.page', 1

class JpgRanger.TaglessPageRoute extends JpgRanger*.BasePhotoPagingRoute
  setupController: (controller, model) ->
    super(controller, model)
    controller.title = 'Tagless'
    controller.preview_route = 'tagless.preview'
    controller.photo_upload_data = {}

  actions:
    change_page: (page) ->
      @transitionTo 'tagless.page', page
    file_uploaded: ->
      @transitionTo 'tagless.page', 1
      @refresh()

class JpgRanger.TaglessPreviewRoute extends JpgRanger*.BasePhotoPreviewRoute
  actions:
    open_full: (photo) ->
      @transitionTo('tagless.full', photo)

class JpgRanger.TaglessFullRoute extends JpgRanger*.BasePhotoFullRoute
