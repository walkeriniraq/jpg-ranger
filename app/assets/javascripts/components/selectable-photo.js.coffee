JpgRanger.SelectablePhotoComponent = Ember.Component.extend
  classNames: ['mini-photo-holder']

  selected: (->
    @get('selected_photos').contains(@get('photo'))
  ).property('selected_photos.[]')

  onClick: ((event)->
    if event.ctrlKey
      @sendAction 'multi_select', @get('photo')
    else if event.shiftKey
      # this clears out the browser selection
      if (document.body.createTextRange)
        document.body.createTextRange().select()
      else if (window.getSelection)
        window.getSelection().removeAllRanges()
      @sendAction 'range_select', @get('photo')
    else
      @sendAction 'single_select', @get('photo')
  ).on('click')
