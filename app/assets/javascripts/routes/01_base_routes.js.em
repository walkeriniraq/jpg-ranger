class JpgRanger.BaseRoute extends Ember.Route
  parent_model: ->
    parent_router_name = @routeName.split('.')
    parent_router_name.pop()
    @modelFor parent_router_name

class JpgRanger.BasePhotoRoute extends JpgRanger*.BaseRoute
  model: (params) ->
    @store.find 'photo', params.id

class JpgRanger.BasePhotoFullRoute extends JpgRanger*.BasePhotoRoute
  controllerName: 'photo.full'
  renderTemplate: -> @render 'photo.full'

class JpgRanger.BasePhotoPreviewRoute extends JpgRanger*.BasePhotoRoute
  controllerName: 'photo.preview'
  renderTemplate: -> @render 'photo.preview'

class JpgRanger.BasePhotoPagingRoute extends JpgRanger*.BaseRoute
  controllerName: 'photo.paging'
  renderTemplate: -> @render 'photo.paging'
  model: (params) ->
    @store.find 'photo', $.extend({ page: params.page }, @parent_model())

  setupController: (controller, model) ->
    super(controller, model)
    controller.meta = Ember.copy(model.meta)
