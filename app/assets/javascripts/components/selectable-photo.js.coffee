JpgRanger.SelectablePhotoComponent = Ember.Component.extend
  classNames: ['mini-photo-holder']
  selected: (->
    @get('photo.selected')
  ).property('photo.selected')

  actions:
    toggle_selection: ->
      @set 'photo.selected', !@get('photo.selected')
    open_preview: ->
      @sendAction('action', @get('photo'))
