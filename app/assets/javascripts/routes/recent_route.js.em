class JpgRanger.RecentRoute extends Ember.Route
  model: ->
    { }

class JpgRanger.RecentIndexRoute extends Ember.Route
  redirect: ->
    @transitionTo 'recent.page', 1

class JpgRanger.RecentPageRoute extends JpgRanger*.BasePhotoPagingRoute
  setupController: (controller, model) ->
    super(controller, model)
    controller.title = 'Recent'
    controller.preview_route = 'recent.preview'
    controller.photo_upload_data = {}

  actions:
    change_page: (page) ->
      @transitionTo 'recent.page', page

class JpgRanger.RecentPreviewRoute extends JpgRanger*.BasePhotoPreviewRoute
  actions:
    open_full: (photo) ->
      @transitionTo('recent.full', photo)

class JpgRanger.RecentFullRoute extends JpgRanger*.BasePhotoFullRoute
