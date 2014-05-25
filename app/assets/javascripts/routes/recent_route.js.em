class JpgRanger.RecentRoute extends Ember.Route
  model: ->
    @store.find 'photo', { order: 'recent' }
