class JpgRanger.ApplicationRoute extends Ember.Route

  actions:
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

    create_tag: ->
      ret = prompt('Type the value of the new tag')
      return unless ret?
      ret = ret.trim().toLowerCase()
      if(ret.length < 1)
        alert 'Please enter a value for the new tag'
        return
      @controller.master_tags_list.pushObject ret

    add_person: (photo, person) ->
      photo.people = [] unless photo.people?
      photo.people.pushObject person
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.people.removeObject person

    add_place: (photo, place) ->
      photo.places = [] unless photo.places?
      photo.places.pushObject place
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.places.removeObject place
      
    add_tag: (photo, tag) ->
      photo.tags.pushObject tag
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.tags.removeObject tag
      