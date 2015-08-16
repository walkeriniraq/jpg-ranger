#JpgRanger.BaseController = Ember.Controller.extend
#  application: Ember.inject.controller()
#
#JpgRanger.PhotoPreviewController = JpgRanger.BaseController.extend
#  computed_people_list: (->
#    @get('application.master_people_list').toArray().removeObjects(@get('model.people') || []).sort()
#  ).property('model.people.[]', 'application.master_people_list.[]', 'application.master_people_list')
#
#  computed_places_list: (->
#    @get('application.master_places_list').toArray().removeObjects(@get('model.places') || []).sort()
#  ).property('model.places.[]', 'application.master_places_list.[]', 'application.master_places_list')
#
#  computed_tags_list: (->
#    @get('application.master_tags_list').toArray().removeObjects(@get('model.tags') || []).sort()
#  ).property('model.tags.[]', 'application.master_tags_list.[]', 'application.master_tags_list')
#
#  computed_collections_list: (->
#    @get('application.master_collection_list').toArray().removeObjects(@get('model.collections') || []).sort()
#  ).property('model.collections.[]', 'application.master_collection_list.[]', 'application.master_collection_list')
#
#  actions:
#    open_full: ->
#      @transitionToRoute(@get('route_base_name') + '.full', @get('model'))
#    previous_photo: ->
#      @get('model').previous_photo(@get('query_params')).done (previous_photo) =>
#        if previous_photo?
#          @transitionToRoute(@get('route_base_name') + '.preview', previous_photo)
#    next_photo: ->
#      @get('model').next_photo(@get('query_params')).done (next_photo) =>
#        if next_photo?
#          @transitionToRoute(@get('route_base_name') + '.preview', next_photo)
#    delete: ->
#      if (window.confirm("Are you sure?"))
#        @get('model').delete().then =>
#          @transitionTo(@get('route_base_name') + '.page', 1)
#
#JpgRanger.PhotoFullController = JpgRanger.BaseController.extend
#  actions:
#    back: ->
#      @transitionToRoute(@get('route_base_name') + '.preview', @get('model'))
#    previous_photo: ->
#      @get('model').previous_photo(@get('query_params')).done (previous_photo) =>
#        if previous_photo?
#          @transitionToRoute(@get('route_base_name') + '.full', previous_photo)
#    next_photo: ->
#      @get('model').next_photo(@get('query_params')).done (next_photo) =>
#        if next_photo?
#          @transitionToRoute(@get('route_base_name') + '.full', next_photo)
#
#JpgRanger.PhotoPagingController = JpgRanger.BaseController.extend
#  selected_photos: []
#
#  actions:
#    tagging_add_person: (person) ->
#      @send 'add_person', @get('selected_photos'), person
#    tagging_add_place: (place) ->
#      @send 'add_place', @get('selected_photos'), place
#    tagging_add_tag: (tag) ->
#      @send 'add_tag', @get('selected_photos'), tag
#    tagging_add_collection: (collection) ->
#      @send 'add_collection', @get('selected_photos'), collection
#    start_upload: ->
#      @get('application').incrementProperty 'uploads_pending'
#    end_upload: ->
#      @get('application').decrementProperty 'uploads_pending'
