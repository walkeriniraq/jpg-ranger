$(document).on 'page:change', ->
  $('#fileupload').fileupload
    dataType: 'json'
    dropZone: $('#photo-upload-div')
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]

  $('#photo-upload-div').click ->
    $('#fileupload').click()
