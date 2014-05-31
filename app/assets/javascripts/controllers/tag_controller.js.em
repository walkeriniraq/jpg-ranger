class JpgRanger.TagController extends JpgRanger*.BaseArrayController

class JpgRanger.TagIndexController extends JpgRanger*.BaseArrayController
  needs: 'tag'
  preview_route: 'tag.preview'
  tag_name: ~> @controllers.tag.tag_name.charAt(0).toUpperCase() + @controllers.tag.tag_name.slice(1)

class JpgRanger.TagPreviewController extends JpgRanger*.BasePreviewController
  actions:
    open_full: (photo) ->
      @transitionToRoute('tag.full', photo)

class JpgRanger.TagFullController extends JpgRanger*.BaseObjectController
