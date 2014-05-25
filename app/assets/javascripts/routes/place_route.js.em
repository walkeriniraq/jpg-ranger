class JpgRanger.PlaceRoute extends Ember.Route
  model: (params) ->
    @last_place_name = params.place_name.charAt(0).toUpperCase() + params.place_name.slice(1)
    @store.find 'photo', { place: params.place_name }

  setupController: (controller, model) ->
    @_super controller, model
    controller.set('place_name', @last_place_name)