class JpgRanger.ApplicationRoute extends Ember.Route

  actions:
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
      