JpgRanger.StatsController = Ember.Controller.extend
  sorted_people: Ember.computed 'model.people.[]', ->
    Ember.ArrayProxy.extend(Ember.SortableMixin).create
      sortProperties: ['value']
      sortAscending: false
      content: this.get('model.people')

  sorted_places: Ember.computed 'model.places.[]', ->
    Ember.ArrayProxy.extend(Ember.SortableMixin).create
      sortProperties: ['value']
      sortAscending: false
      content: this.get('model.places')

  sorted_tags: Ember.computed 'model.tags.[]', ->
    Ember.ArrayProxy.extend(Ember.SortableMixin).create
      sortProperties: ['value']
      sortAscending: false
      content: this.get('model.tags')

  sorted_collections: Ember.computed 'model.collections.[]', ->
    Ember.ArrayProxy.extend(Ember.SortableMixin).create
      sortProperties: ['value']
      sortAscending: false
      content: this.get('model.collections')

  actions:
    view_collection: (collection) ->
      @transitionToRoute('browse', {queryParams: { people: [collection] }})
    view_place: (place) ->
      @transitionToRoute('browse', {queryParams: { places: [place] }})
    view_tag: (tag) ->
      @transitionToRoute('browse', {queryParams: { tag: [tag] }})
    view_collection: (collection) ->
      @transitionToRoute('browse', {queryParams: { collections: [collection] }})
