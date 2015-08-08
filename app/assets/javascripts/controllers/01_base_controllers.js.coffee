JpgRanger.BaseController = Ember.Controller.extend
  needs: 'application'

JpgRanger.BaseArrayController = Ember.ArrayController.extend
  needs: 'application'

JpgRanger.PhotoPreviewController = JpgRanger.BaseController.extend
  computed_people_list: (->
    @get('controllers.application.master_people_list').toArray().removeObjects(@get('model.people') || []).sort()
  ).property('model.people.@each', 'controllers.application.master_people_list.@each', 'controllers.application.master_people_list')

  computed_places_list: (->
    @get('controllers.application.master_places_list').toArray().removeObjects(@get('model.places') || []).sort()
  ).property('model.places.@each', 'controllers.application.master_places_list.@each', 'controllers.application.master_places_list')

  computed_tags_list: (->
    @get('controllers.application.master_tags_list').toArray().removeObjects(@get('model.tags') || []).sort()
  ).property('model.tags.@each', 'controllers.application.master_tags_list.@each', 'controllers.application.master_tags_list')

  computed_collections_list: (->
    @get('controllers.application.master_collection_list').toArray().removeObjects(@get('model.collections') || []).sort()
  ).property('model.collections.@each', 'controllers.application.master_collection_list.@each', 'controllers.application.master_collection_list')

JpgRanger.PhotoPagingController = JpgRanger.BaseArrayController.extend
  total_pages: (->
    @get 'model.meta.total_pages'
  ).property('model.meta.total_pages')
  current_page: (->
    @get 'model.meta.page'
  ).property('model.meta.page')
  has_next_page: (->
    @get('current_page') < @get('total_pages')
  ).property('current_page', 'total_pages')
  has_previous_page: (->
    @get('current_page') > 1
  ).property('current_page')
  next_page: (->
    @get('current_page') + 1
  ).property('current_page')
  previous_page: (->
    @get('current_page') - 1
  ).property('current_page')
