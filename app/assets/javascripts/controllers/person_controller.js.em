class JpgRanger.PersonController extends JpgRanger*.BaseArrayController

class JpgRanger.PersonIndexController extends JpgRanger*.BaseArrayController
  needs: 'person'
  preview_route: 'person.preview'
  person_name: ~> @controllers.person.person_name
  person_name_display: ~> @person_name.charAt(0).toUpperCase() + @person_name.slice(1)

class JpgRanger.PersonPreviewController extends JpgRanger*.BasePreviewController
  actions:
    open_full: (photo) ->
      @transitionToRoute('person.full', photo)

class JpgRanger.PlaceFullController extends JpgRanger*.BaseObjectController
