# For more information see: http://emberjs.com/guides/routing/

class JpgRanger.TagRoute extends Ember.Route
  model: (params) ->
    @last_tag_name = params.tag_name.charAt(0).toUpperCase() + params.tag_name.slice(1)
    @store.find 'photo', { tag: params.tag_name }

  setupController: (controller, model) ->
    @_super controller, model
    controller.set('tag_name', @last_tag_name)
