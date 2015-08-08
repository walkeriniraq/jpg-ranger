JpgRanger.CollectionRoute = Ember.Route.extend
  model: (params) ->
    { collection: params.collection_name }

JpgRanger.CollectionIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'collection.page', params.collection, 1

JpgRanger.CollectionPageRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'photo', { page: params.page, collection: @modelFor('collection').collection }
  actions:
    change_page: (page) ->
      @transitionTo 'collection.page', @modelFor('collection').collection, page
    open_preview: (photo) ->
      @transitionTo 'collection.preview', @modelFor('collection').collection, photo
    file_uploaded: ->
      @transitionTo 'collection.page', @modelFor('collection').collection, 1
      @refresh()

JpgRanger.CollectionPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('collection.full', @modelFor('collection').collection, photo.id)

JpgRanger.CollectionFullRoute = JpgRanger.BasePhotoRoute.extend()
