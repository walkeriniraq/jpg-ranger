#JpgRanger.BaseRoute = Ember.Route.extend
#  parent_model: ->
#    parent_router_name = @get('routeName').split('.')
#    parent_router_name.pop()
#    @modelFor parent_router_name
#
#JpgRanger.BasePhotoFullRoute = JpgRanger.BasePhotoRoute.extend
#  controllerName: 'photo.full'
#  renderTemplate: ->
#    @render 'photo.full'
#
#JpgRanger.BasePhotoPreviewRoute = JpgRanger.BasePhotoRoute.extend
#  controllerName: 'photo.preview'
#  renderTemplate: ->
#    @render 'photo.preview'
#
#JpgRanger.BasePhotoPagingRoute = JpgRanger.BaseRoute.extend
#  controllerName: 'photo.paging'
#  renderTemplate: ->
#    @render 'photo.paging'
#  model: (params) ->
#    @get('store').find 'photo', $.extend({ page: params.page }, @parent_model())
#
#  setupController: (controller, model) ->
#    @_super(controller, model)
#    controller.set('meta', Ember.copy(model.meta))

JpgRanger.BasePhotoRoute = Ember.Route.extend
  model: (params) ->
    @get('store').findRecord 'photo', params.id
