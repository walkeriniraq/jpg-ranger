class JpgRanger.PlaceController extends JpgRanger*.BaseArrayController

class JpgRanger.PlaceIndexController extends JpgRanger*.BaseArrayController
  needs: 'place'
  preview_route: 'place.preview'
  place_name: ~> @controllers.place.place_name

class JpgRanger.PlacePreviewController extends JpgRanger*.BasePreviewController
  actions:
    open_full: (photo) ->
      @transitionToRoute('place.full', photo)

class JpgRanger.PlaceFullController extends JpgRanger*.BaseObjectController
