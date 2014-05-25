class JpgRanger.PlacePreviewRoute extends Ember.Route
  model: (params) ->
    @store.find 'photo', params.id
