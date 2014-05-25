class JpgRanger.PhotoRoute extends Ember.Route
  model: (params) ->
    @store.find 'photo', params.id
