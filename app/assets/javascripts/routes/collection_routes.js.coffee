JpgRanger.CollectionIndexRoute = Ember.Route.extend
  model: ->
    JpgRanger.Collection.list()
  actions:
    file_uploaded: ->
      @refresh()

JpgRanger.CollectionViewRoute = Ember.Route.extend
  model: (params) ->
    JpgRanger.Collection.get(params.collection_name)

  actions:
    file_uploaded: ->
      @refresh()

#JpgRanger.PhotosCollectionListIndexRoute = Ember.Route.extend
#  model: (params) ->
#    { collection: params.collection_name }
##  model: (params) ->
##    @store.query 'photo', { page: params.page, collection: @modelFor('collection').collection }
##  actions:
##    change_page: (page) ->
##      @transitionTo 'collection.page', @modelFor('collection').collection, page
##    open_preview: (photo) ->
##      @transitionTo 'collection.preview', @modelFor('collection').collection, photo
##    file_uploaded: ->
##      @transitionTo 'collection.page', @modelFor('collection').collection, 1
##      @refresh()
#
#JpgRanger.PhotosCollectionListPreviewRoute = JpgRanger.BasePhotoRoute.extend()
#
#JpgRanger.PhotosCollectionListFullRoute = JpgRanger.BasePhotoRoute.extend()
