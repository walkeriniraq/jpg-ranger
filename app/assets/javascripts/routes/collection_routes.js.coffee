JpgRanger.CollectionRoute = Ember.Route.extend
  model: (params) ->
    { collection: params.collection_name }

JpgRanger.CollectionIndexRoute = Ember.Route.extend
  redirect: (params) ->
    @transitionTo 'collection.page', params.collection, 1

JpgRanger.CollectionPageRoute = Ember.Route.extend
  model: (params) ->
    @store.query 'photo', { page: params.page, collection: @modelFor('collection').collection }
  actions:
    change_page: (page) ->
      @transitionTo 'collection.page', @modelFor('collection').collection, page
    open_preview: (photo) ->
      @transitionTo 'collection.preview', @modelFor('collection').collection, photo
    file_uploaded: ->
      @transitionTo 'collection.page', @modelFor('collection').collection, 1
      @refresh()

JpgRanger.CollectionPreviewRoute = JpgRanger.BasePhotoRoute.extend()

JpgRanger.CollectionFullRoute = JpgRanger.BasePhotoRoute.extend()
