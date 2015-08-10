JpgRanger.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'recent.page', 1

JpgRanger.ApplicationRoute = Ember.Route.extend
  create_person: ->
    ret = prompt('Who do you want to add?')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a name for the new person'
      return
    @controller.master_people_list.pushObject ret

  create_place: ->
    ret = prompt('What is the name of the place?')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a value for the new place'
      return
    @controller.master_places_list.pushObject ret
    ret

  create_tag: ->
    ret = prompt('Type the value of the new tag')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a value for the new tag'
      return
    @controller.master_tags_list.pushObject ret

  create_collection: ->
    ret = prompt('What is the name of the new collection?')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a value for the new collection'
      return
    @controller.master_collection_list.pushObject ret

  actions:
    start_upload: ->
      @controller.incrementProperty 'uploads_pending'
    end_upload: ->
      @controller.decrementProperty 'uploads_pending'

    create_person: ->
      @create_person()
    create_place: ->
      @create_place()
    create_tag: ->
      @create_tag()
    create_collection: ->
      @create_collection()

    # TODO: move this into the tagging component
    add_person: (photo, person) ->
      person = @create_person() unless person?
      return unless person?
      if photo.constructor == JpgRanger.Photo
        photo.get('people').pushObject person
        photo.save().catch (err) ->
          console.log err
          alert 'There was a problem saving to the database.'
          photo.people.removeObject person
      else
        JpgRanger.Photo.add_person_multiple(person, photo).then =>
          photo.forEach (photo) ->
            photo.get('people').addObject(person)

    add_place: (photo, place) ->
      place = @create_place() unless place?
      return unless place?
      if photo.constructor == JpgRanger.Photo
        photo.get('places').pushObject place
        photo.save().catch (err) ->
          console.log err
          alert 'There was a problem saving to the database.'
          photo.places.removeObject place
      else
        JpgRanger.Photo.add_place_multiple(place, photo).then =>
          photo.forEach (photo) ->
            photo.get('places').addObject(place)
      
    add_tag: (photo, tag) ->
      tag = @create_tag() unless tag?
      return unless tag?
      if photo.constructor == JpgRanger.Photo
        photo.get('tags').pushObject tag
        photo.save().catch (err) ->
          console.log err
          alert 'There was a problem saving to the database.'
          photo.tags.removeObject tag
      else
        JpgRanger.Photo.add_tag_multiple(tag, photo).then =>
          photo.forEach (photo) ->
            photo.get('tags').addObject(tag)

    add_collection: (photo, collection) ->
      collection = @create_collection() unless collection?
      return unless collection?
      if photo.constructor == JpgRanger.Photo
        photo.get('collections').pushObject collection
        photo.save().catch (err) ->
          console.log err
          alert 'There was a problem saving to the database.'
          photo.collections.removeObject collection
      else
        JpgRanger.Photo.add_collection_multiple(collection, photo).then =>
          photo.forEach (photo) ->
            photo.get('collections').addObject(collection)

    remove_person: (photo, person) ->
      photo.get('people').removeObject person
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.people.pushObject person

    remove_place: (photo, place) ->
      photo.get('places').removeObject place
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.places.pushObject place

    remove_tag: (photo, tag) ->
      photo.get('tags').removeObject tag
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.tags.pushObject tag

    remove_collection: (photo, collection) ->
      photo.get('collections').removeObject collection
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.collections.pushObject collection
     