class JpgRanger.PlaceRoute extends Ember.Route
  model: (params) ->
    { place: params.place_name }

class JpgRanger.PlaceIndexRoute extends Ember.Route
  redirect: (params) ->
    @transitionTo 'place.page', params.place, 1

class JpgRanger.PlacePageRoute extends JpgRanger*.BasePhotoPagingRoute
  setupController: (controller, model) ->
    super(controller, model)
    place = @parent_model().place
    controller.title = place
    controller.preview_route = 'place.preview'
    controller.photo_upload_data = { place: place }

class JpgRanger.PlacePreviewRoute extends JpgRanger*.BasePhotoPreviewRoute
  actions:
    open_full: (photo) ->
      @transitionTo('place.full', @parent_model().place, photo.id)

class JpgRanger.PlaceFullRoute extends JpgRanger*.BasePhotoFullRoute
