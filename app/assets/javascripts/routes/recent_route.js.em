# For more information see: http://emberjs.com/guides/routing/

class JpgRanger.RecentRoute extends Ember.Route
  model: ->
    @store.find 'photo', { order: 'recent' }