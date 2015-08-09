JpgRanger.BaseController = Ember.Controller.extend
  application: Ember.inject.controller()

JpgRanger.PhotoPreviewController = JpgRanger.BaseController.extend
  computed_people_list: (->
    @get('application.master_people_list').toArray().removeObjects(@get('model.people') || []).sort()
  ).property('model.people.[]', 'application.master_people_list.[]', 'application.master_people_list')

  computed_places_list: (->
    @get('application.master_places_list').toArray().removeObjects(@get('model.places') || []).sort()
  ).property('model.places.[]', 'application.master_places_list.[]', 'application.master_places_list')

  computed_tags_list: (->
    @get('application.master_tags_list').toArray().removeObjects(@get('model.tags') || []).sort()
  ).property('model.tags.[]', 'application.master_tags_list.[]', 'application.master_tags_list')

  computed_collections_list: (->
    @get('application.master_collection_list').toArray().removeObjects(@get('model.collections') || []).sort()
  ).property('model.collections.[]', 'application.master_collection_list.[]', 'application.master_collection_list')

JpgRanger.PhotoPagingController = JpgRanger.BaseController.extend
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
