JpgRanger.TaglessPageController = JpgRanger.PhotoPagingController.extend
  actions:
    add_person: (person) ->
      JpgRanger.Photo.add_person_multiple(person, @get('model').filterBy('selected')).then =>
        @send('reload')
    add_place: (place) ->
      JpgRanger.Photo.add_place_multiple(place, @get('model').filterBy('selected')).then =>
        @send('reload')
    add_tag: (tag) ->
      JpgRanger.Photo.add_tag_multiple(tag, @get('model').filterBy('selected')).then =>
        @send('reload')
    add_collection: (collection) ->
      JpgRanger.Photo.add_collection_multiple(collection, @get('model').filterBy('selected')).then =>
        @send('reload')

JpgRanger.TaglessPreviewController = JpgRanger.PhotoPreviewController.extend()
