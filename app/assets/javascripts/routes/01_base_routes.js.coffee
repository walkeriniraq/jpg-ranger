JpgRanger.BasePhotoRoute = Ember.Route.extend
  model: (params) ->
    @get('store').findRecord 'photo', params.id
