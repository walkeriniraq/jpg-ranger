JpgRanger.ApplicationController = Ember.Controller.extend
  master_people_list: []
  master_places_list: []
  master_tags_list: []
  master_collection_list: []
  uploads_pending: 0
  search_term: null

  init: ->
    $.ajax('/globals', dataType: 'json', cache: false).done (data) =>
      @master_tags_list.pushObjects data.tags
      @master_places_list.pushObjects data.places
      @master_people_list.pushObjects data.people
      @master_collection_list.pushObjects data.collections

  has_uploads_pending: (->
    @get('uploads_pending')
  ).property('uploads_pending')

  hide_menu: Ember.computed.match 'currentRouteName', /full/
  hide_filters: Ember.computed.match 'currentRouteName', /preview|full/

  sorted_people_list: Ember.computed 'master_people_list.[]', ->
    @get('master_people_list').sort()

  sorted_places_list: Ember.computed 'master_places_list.[]', ->
    @get('master_places_list').sort()

  sorted_tags_list: Ember.computed 'master_tags_list.[]', ->
    @get('master_tags_list').sort()

  sorted_collection_list: Ember.computed 'master_collection_list.[]', ->
    @get('master_collection_list').sort()

  create_tag: (type) ->
    ret = switch type
      when 'person' then prompt('Who do you want to add?')
      when 'place' then prompt('What is the name of the place?')
      when 'tag' then prompt('What is the new tag?')
      when 'collection' then prompt('Name the new collection:')
      else throw "Invalid tag type: #{type}"
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert "Invalid tag name: #{ret}"
      return
    switch type
      when 'person' then @get('master_people_list').addObject(ret)
      when 'place' then @get('master_places_list').addObject(ret)
      when 'tag' then @get('master_tags_list').addObject(ret)
      when 'collection' then @get('master_collection_list').addObject(ret)
    ret

  actions:
    search: ->
      @transitionToRoute 'browse', queryParams: { search_term: @get('search_term') }

