class JpgRanger.IndexRoute extends Ember.Route
  redirect: ->
    @transitionTo 'recent.page', 1

class JpgRanger.ApplicationRoute extends Ember.Route

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

  actions:
    create_person: ->
      @create_person()
    create_place: ->
      @create_place()
    create_tag: ->
      @create_tag()

    add_person: (photo, person) ->
      person = @create_person() unless person?
      return unless person?
      photo.people = [] unless photo.people?
      photo.people.pushObject person
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.people.removeObject person

    add_place: (photo, place) ->
      place = @create_place() unless place?
      return unless place?
      photo.places = [] unless photo.places?
      photo.places.pushObject place
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.places.removeObject place
      
    add_tag: (photo, tag) ->
      tag = @create_tag() unless tag?
      return unless tag?
      photo.tags = [] unless photo.tags?
      photo.tags.pushObject tag
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.tags.removeObject tag

    remove_person: (photo, person) ->
      photo.people.removeObject person
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.people.pushObject person

    remove_place: (photo, place) ->
      photo.places.removeObject place
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.places.pushObject place

    remove_tag: (photo, tag) ->
      photo.tags.removeObject tag
      photo.save().catch (err) ->
        console.log err
        alert 'There was a problem saving to the database.'
        photo.tags.pushObject tag
