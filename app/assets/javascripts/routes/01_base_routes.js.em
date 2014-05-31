class JpgRanger.BasePhotoRoute extends Ember.Route
  model: (params) ->
    @store.find 'photo', params.id
