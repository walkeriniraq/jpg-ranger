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

JpgRanger.CollectionPreviewRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    open_full: (photo) ->
      @transitionTo('collection.full', @modelFor('collection').collection, photo.id)
    previous: (photo) ->
      photo.previous_photo({collection: @modelFor('collection').collection}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('collection.preview', @modelFor('collection').collection, previous_photo)
    next: (photo) ->
      photo.next_photo({collection: @modelFor('collection').collection}).done (next_photo) =>
        if next_photo?
          @transitionTo('collection.preview', @modelFor('collection').collection, next_photo)
    delete: (photo) ->
      if (window.confirm("Are you sure?"))
        photo.delete().then =>
          @transitionTo('collection.page', @modelFor('collection').collection, 1)

JpgRanger.CollectionFullRoute = JpgRanger.BasePhotoRoute.extend
  actions:
    previous: (photo) ->
      photo.previous_photo({collection: @modelFor('collection').collection}).done (previous_photo) =>
        if previous_photo?
          @transitionTo('collection.full', @modelFor('collection').collection, previous_photo)
    next: (photo) ->
      photo.next_photo({collection: @modelFor('collection').collection}).done (next_photo) =>
        if next_photo?
          @transitionTo('collection.full', @modelFor('collection').collection, next_photo)

