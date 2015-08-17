JpgRanger.BrowseRoute = Ember.Route.extend
  queryParams:
    people:
      refreshModel: true
    places:
      refreshModel: true
    tags:
      refreshModel: true
    collections:
      refreshModel: true
    search_term:
      refreshModel: true
    sort_by:
      refreshModel: true

  actions:
    previous_photo: (route, photo) ->
      photo.previous_photo(this.paramsFor('browse')).done (previous_photo) =>
        if previous_photo?
          @transitionTo(route, previous_photo)
    next_photo: (route, photo) ->
      photo.next_photo(this.paramsFor('browse')).done (next_photo) =>
        @transitionTo(route, next_photo) if next_photo?

JpgRanger.BrowseIndexRoute = Ember.Route.extend
  queryParams:
    page:
      refreshModel: true

  model: (params) ->
    @store.query('photo', Ember.$.extend(params, this.paramsFor('browse')))

JpgRanger.BrowsePreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.BrowseFullRoute = JpgRanger.BasePhotoRoute.extend()