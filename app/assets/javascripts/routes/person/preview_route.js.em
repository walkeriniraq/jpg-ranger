class JpgRanger.PersonPreviewRoute extends Ember.Route
  model: (params) ->
    @store.find 'photo', params.id
