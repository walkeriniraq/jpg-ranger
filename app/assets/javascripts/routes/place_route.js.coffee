JpgRanger.PlaceRoute = Ember.Route.extend
  model: (params) ->
    { place: params.place_name }

JpgRanger.PlaceIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'place.page', params.place, 1

JpgRanger.PlacePageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page, place: @modelFor('place').place }
  actions:
    change_page: (page) ->
      @transitionTo 'place.page', @modelFor('place').place, page
    open_preview: (photo) ->
      @transitionTo 'place.preview', @modelFor('place').place, photo
    file_uploaded: ->
      @transitionTo 'place.page', @modelFor('place').place, 1
      @refresh()

JpgRanger.PlacePreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('place.full', @modelFor('place').place, photo.id)
    previous: (photo) ->
      photo.previous_photo({place: @modelFor('place').place}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('place.preview', @modelFor('place').place, previous_photo)
    next: (photo) ->
      photo.next_photo({place: @modelFor('place').place}).done (next_photo) =>
        if next_photo?
          @transitionTo('place.preview', @modelFor('place').place, next_photo)
    delete: (photo) ->
      if (window.confirm("Are you sure?"))
        photo.delete().then =>
          @transitionTo('place.page', @modelFor('place').place, 1)

JpgRanger.PlaceFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({place: @modelFor('place').place}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('place.full', @modelFor('place').place, previous_photo)
    next: (photo) ->
      photo.next_photo({place: @modelFor('place').place}).done (next_photo) =>
        if next_photo?
          @transitionTo('place.full', @modelFor('place').place, next_photo)

