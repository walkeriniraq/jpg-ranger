JpgRanger.PhotoTaggingComponent = Ember.Component.extend
  actions:
    tagging: (type, value) ->
      @sendAction 'tagging', type, value