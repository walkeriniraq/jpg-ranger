JpgRanger.PhotoUploadComponent = Ember.Component.extend

  form_data: Ember.observer 'upload_data', ->
    $('#fileupload').fileupload 'option', 'formData', $.extend { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') }, @get('upload_data')

  didInsertElement: ->
    $('#fileupload').fileupload
      dataType: 'json'
      dropZone: $('#photo-upload-div')
      add: (e, data) =>
        @sendAction('start_upload')
        data.submit()
      always: =>
        @sendAction('end_upload')
      stop: =>
        @sendAction('file_uploaded')
      fail: ->
        alert 'An upload has failed!'

    $('#photo-upload-div').click ->
      $('#fileupload').click()

