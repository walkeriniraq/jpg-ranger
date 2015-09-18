JpgRanger.BrowseRoute = Ember.Route.extend
  queryParams:
    people:
      refreshModel: true
    places:
      refreshModel: true
    tags:
      refreshModel: true
    collections:
      refreshModel: true
    search_term:
      refreshModel: true
    sort_by:
      refreshModel: true

JpgRanger.BrowseIndexRoute = Ember.Route.extend
  queryParams:
    page:
      refreshModel: true

  model: (params) ->
    @store.query('photo', Ember.$.extend(params, @paramsFor('browse')))

JpgRanger.BrowsePreviewRoute = JpgRanger.BasePhotoRoute.extend
  setupController: (controller, photo) ->
    @_super(controller, photo)
    @set 'next_id', null
    @set 'prev_id', null
    return unless photo?
    Ember.run.once =>
      photo.get_next_ids(@paramsFor('browse')).then (data) =>
        @set 'next_id', data.next
        @set 'prev_id', data.prev
        # TODO: set has_next_id into the controller
        # TODO: also dry this up

  actions:
    previous: ->
      return unless @get('prev_id')?
      @transitionTo('browse.preview', @get('prev_id'))
    next: ->
      return unless @get('next_id')?
      @transitionTo('browse.preview', @get('next_id'))

JpgRanger.BrowseFullRoute = JpgRanger.BasePhotoRoute.extend
  setupController: (controller, photo) ->
    @_super(controller, photo)
    @set 'next_id', null
    @set 'prev_id', null
    return unless photo?
    Ember.run.once =>
      photo.get_next_ids(@paramsFor('browse')).then (data) =>
        @set 'next_id', data.next
        @set 'prev_id', data.prev
        # TODO: set has_next_id into the controller

  actions:
    previous: ->
      return unless @get('prev_id')?
      @transitionTo('browse.full', @get('prev_id'))
    next: ->
      return unless @get('next_id')?
      @transitionTo('browse.full', @get('next_id'))
