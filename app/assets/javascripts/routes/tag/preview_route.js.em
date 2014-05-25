class JpgRanger.TagPreviewRoute extends Ember.Route
  model: (params) ->
    @store.find 'photo', params.id
