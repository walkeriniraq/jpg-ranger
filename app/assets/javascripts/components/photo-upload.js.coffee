JpgRanger.PhotoUploadComponent = Ember.Component.extend

  click: ->
    @sendAction('action', @get('model.name'))

  reset_form_data: Ember.observer 'upload_data', ->
    @$('.fileupload').fileupload 'option', 'formData', @form_data()

  form_data: ->
    $.extend { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') }, @get('upload_data')

  didInsertElement: ->
    @$('.fileupload').fileupload
      dataType: 'json'
      dropZone: @$()
      formData: @form_data()
      add: (e, data) =>
        @sendAction('start_upload')
        data.submit()
      always: =>
        @sendAction('end_upload')
      stop: =>
        @sendAction('file_uploaded')
      fail: ->
        alert 'An upload has failed!'
