class JpgRanger.BasePreviewController extends Ember.ObjectController
  needs: 'application'

  +computed model.people.@each, controllers.application.master_people_list.@each, controllers.application.master_people_list
  master_people_list: -> @controllers.application.master_people_list.toArray().removeObjects(@model.people || []).sort()

  +computed model.places.@each, controllers.application.master_places_list.@each, controllers.application.master_places_list
  master_places_list: -> @controllers.application.master_places_list.toArray().removeObjects(@model.places || []).sort()

  +computed model.tags.@each, controllers.application.master_tags_list.@each, controllers.application.master_tags_list
  master_tags_list: -> @controllers.application.master_tags_list.toArray().removeObjects(@model.tags || []).sort()
  