class JpgRanger.UploadView extends Ember.View
  needs: ['application']

  form_data: ->
    $.extend { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') }, @controller.photo_upload_data

  didInsertElement: ->
    $('#fileupload').fileupload
      dataType: 'json'
      dropZone: $('#photo-upload-div')
      formData: @form_data()
      add: (e, data) =>
        @get('controller').send('start_upload')
        data.submit()
      always: =>
        @get('controller').send('end_upload')
      stop: =>
        @get('controller').send('file_uploaded')
      fail: ->
        alert 'An upload has failed!'

    $('#photo-upload-div').click ->
      $('#fileupload').click()

class JpgRanger.PhotoPagingView extends JpgRanger*.UploadView
  layoutName: 'nav_layout'

class JpgRanger.PhotoPreviewView extends Ember.View
  layoutName: 'nav_layout'