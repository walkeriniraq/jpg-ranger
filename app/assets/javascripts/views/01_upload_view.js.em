class JpgRanger.UploadView extends Ember.View
  extra_form_data: {}

  form_data: ->
    $.extend { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') }, @extra_form_data

  didInsertElement: ->
    $('#fileupload').fileupload
      dataType: 'json'
      dropZone: $('#photo-upload-div')
      formData: @form_data()

    $('#photo-upload-div').click ->
      $('#fileupload').click()
