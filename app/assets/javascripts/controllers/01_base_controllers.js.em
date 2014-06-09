class JpgRanger.BaseController extends Ember.Controller
  needs: 'application'

class JpgRanger.BaseObjectController extends Ember.ObjectController
  needs: 'application'

class JpgRanger.BaseArrayController extends Ember.ArrayController
  needs: 'application'

class JpgRanger.PhotoPreviewController extends JpgRanger*.BaseObjectController
  +computed model.people.@each, controllers.application.master_people_list.@each, controllers.application.master_people_list
  computed_people_list: -> @controllers.application.master_people_list.toArray().removeObjects(@model.people || []).sort()

  +computed model.places.@each, controllers.application.master_places_list.@each, controllers.application.master_places_list
  computed_places_list: -> @controllers.application.master_places_list.toArray().removeObjects(@model.places || []).sort()

  +computed model.tags.@each, controllers.application.master_tags_list.@each, controllers.application.master_tags_list
  computed_tags_list: -> @controllers.application.master_tags_list.toArray().removeObjects(@model.tags || []).sort()

class JpgRanger.PhotoPagingController extends JpgRanger*.BaseArrayController
  total_pages: ~> @meta.total_pages
  current_page: ~> @meta.page
  has_next_page: ~> @current_page < @total_pages
  has_previous_page: ~> @current_page > 1
#  actions:
#    next_page: ->
#      @target.page @current_page + 1, @

class JpgRanger.PhotoFullController extends JpgRanger*.BaseObjectController