class JpgRanger.RecentController extends JpgRanger*.BaseArrayController

class JpgRanger.RecentIndexController extends JpgRanger*.BaseArrayController
  preview_route: 'recent.preview'

class JpgRanger.RecentPreviewController extends JpgRanger*.BasePreviewController
  actions:
    open_full: (photo) ->
      @transitionToRoute('recent.full', photo)

class JpgRanger.RecentFullController extends JpgRanger*.BaseObjectController
