JpgRanger.PhotoPagingComponent = Ember.Component.extend

  becomeFocused: (->
      @$('button:first').focus()
  ).on('didInsertElement')

  actions:
    previous: ->
      @sendAction('previous_photo')
    next: ->
      @sendAction('next_photo')

  keyUp: (evt) ->
    if(evt.keyCode == 37)
      @sendAction('previous_photo')
    else if evt.keyCode == 39
      @sendAction('next_photo')