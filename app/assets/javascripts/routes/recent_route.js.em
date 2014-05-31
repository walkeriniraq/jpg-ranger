class JpgRanger.RecentRoute extends Ember.Route
  model: ->
    @store.find 'photo', { order: 'recent' }

class JpgRanger.RecentPreviewRoute extends JpgRanger*.BasePhotoRoute

class JpgRanger.RecentFullRoute extends JpgRanger*.BasePhotoRoute
