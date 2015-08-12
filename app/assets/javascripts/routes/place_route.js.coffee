JpgRanger.PlaceRoute = Ember.Route.extend
  model: (params) ->
    { place: params.place_name }

JpgRanger.PlaceIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'place.page', params.place, 1

JpgRanger.PlacePageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', { page: params.page, place: @modelFor('place').place }
  actions:
    change_page: (page) ->
      @transitionTo 'place.page', @modelFor('place').place, page
    open_preview: (photo) ->
      @transitionTo 'place.preview', @modelFor('place').place, photo
    file_uploaded: ->
      @transitionTo 'place.page', @modelFor('place').place, 1
      @refresh()

JpgRanger.PlacePreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.PlaceFullRoute = JpgRanger.BasePhotoRoute.extend()
