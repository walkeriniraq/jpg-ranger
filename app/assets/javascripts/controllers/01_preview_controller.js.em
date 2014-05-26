class JpgRanger.BasePreviewController extends Ember.ObjectController
  needs: 'application'

  +computed model.people.@each, controllers.application.master_people_list.@each, controllers.application.master_people_list
  master_people_list: -> @controllers.application.master_people_list.toArray().removeObjects(@model.people || [])
