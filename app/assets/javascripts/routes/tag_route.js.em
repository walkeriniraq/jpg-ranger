class JpgRanger.TagRoute extends Ember.Route
  model: (params) ->
    @last_tag_name = params.tag_name
    @store.find 'photo', { tag: params.tag_name }

  setupController: (controller, model) ->
    @_super controller, model
    controller.set('tag_name', @last_tag_name)

class JpgRanger.TagPreviewRoute extends JpgRanger*.BasePhotoRoute

class JpgRanger.TagFullRoute extends JpgRanger*.BasePhotoRoute
