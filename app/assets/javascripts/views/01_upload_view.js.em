class JpgRanger.UploadView extends Ember.View
  form_data: ->
    $.extend { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') }, @controller.photo_upload_data

  didInsertElement: ->
    $('#fileupload').fileupload
      dataType: 'json'
      dropZone: $('#photo-upload-div')
      formData: @form_data()

    $('#photo-upload-div').click ->
      $('#fileupload').click()

class JpgRanger.PhotoPagingView extends JpgRanger*.UploadView
  layoutName: 'nav_layout'

class JpgRanger.PhotoPreviewView extends Ember.View
  layoutName: 'nav_layout'