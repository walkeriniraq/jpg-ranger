JpgRanger.BrowseController = Ember.Controller.extend
  application: Ember.inject.controller()
  queryParams: ['people', 'places', 'tags', 'collections', 'search_term', 'sort_by']
  people: []
  places: []
  tags: []
  collections: []
  search_term: null
  sort_by: 'upload_date'

  sort_options: [
    { label: 'Upload time (most recent first)', value: 'upload_date'}
    { label: 'Tags (fewest first)', value: 'tags'}
    { label: 'Photo size (smallest first)', value: 'photo_size'}
    { label: 'Original filename', value: 'filename'}
  ]

  has_people_filters: Ember.computed.notEmpty 'people'
  has_place_filters: Ember.computed.notEmpty 'places'
  has_tag_filters: Ember.computed.notEmpty 'tags'
  has_collection_filters: Ember.computed.notEmpty 'collections'
  has_search_term: Ember.computed.notEmpty 'search_term'

  has_filters: Ember.computed.or 'has_people_filters', 'has_place_filters', 'has_tag_filters', 'has_collection_filters', 'has_search_term'

  actions:
    add_filter: (type, value) ->
      switch type
        when 'person' then @get('people').addObject(value)
        when 'place' then @get('places').addObject(value)
        when 'tag' then @get('tags').addObject(value)
        when 'collection'then @get('collections').addObject(value)
        else throw "Invalid filter type: #{type} for value #{value}"

    remove_filter: (type, value) ->
      switch type
        when 'person' then @get('people').removeObject(value)
        when 'place' then @get('places').removeObject(value)
        when 'tag' then @get('tags').removeObject(value)
        when 'collection'then @get('collections').removeObject(value)
        else throw "Invalid filter type: #{type} for value #{value}"

    remove_search_term: ->
      @set('search_term', null)

    clear_filters: ->
      @get('people').clear()
      @get('places').clear()
      @get('tags').clear()
      @get('collections').clear()
      @set('search_term', null)

JpgRanger.BrowseIndexController = Ember.Controller.extend
  application: Ember.inject.controller()
  queryParams: ['page']
  page: 1
  selected_photos: []

  actions:
    change_page: (page) ->
      @set('page', page)
    add_tag: (type, value) ->
      # TODO: if all photos have the tag then remove it
      value = @get('application').create_tag(type) unless value?
      return unless value?
      switch type
        when 'person' then JpgRanger.Photo.add_person_multiple(value, @get('selected_photos'))
        when 'place' then JpgRanger.Photo.add_place_multiple(value, @get('selected_photos'))
        when 'tag' then JpgRanger.Photo.add_tag_multiple(value, @get('selected_photos'))
        when 'collection' then JpgRanger.Photo.set_collection_multiple(value, @get('selected_photos'))
        else throw "Invalid tag type: #{type}"

JpgRanger.BrowsePreviewController = Ember.Controller.extend
  application: Ember.inject.controller()

  actions:
    open_full: ->
      @transitionToRoute('browse.full', @get('model'))
    delete: ->
      if (window.confirm("Are you sure?"))
        @get('model').delete().then =>
          @transitionToRoute('browse')
    next: ->
      @send('next_photo', 'browse.preview', @get('model'))
    previous: ->
      @send('previous_photo', 'browse.preview', @get('model'))
    add_tag: (type, value) ->
      value = @get('application').create_tag(type) unless value?
      return unless value?
      @get('model').add_tag type, value
    remove_tag: (type, value) ->
      return unless value?
      @get('model').remove_tag type, value

JpgRanger.BrowseFullController = Ember.Controller.extend
  actions:
    back: ->
      @transitionToRoute('browse.preview', @get('model'))
    next: ->
      @send('next_photo', 'browse.full', @get('model'))
    previous: ->
      @send('previous_photo', 'browse.full', @get('model'))
