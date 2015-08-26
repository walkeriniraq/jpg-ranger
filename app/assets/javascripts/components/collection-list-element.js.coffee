JpgRanger.CollectionListElementComponent = Ember.Component.extend
  collection: null
  upload_data: Ember.computed 'collection.name', ->
    { collection: @get('collection.name') }

  click: ->
    @sendAction 'action', @get('collection.name')

  actions:
    start_upload: ->
      @sendAction 'start_upload'
    end_upload: ->
      @sendAction 'end_upload'
    file_uploaded: ->
      @sendAction 'file_uploaded'