$(document).on 'page:change', ->
  $('#fileupload').fileupload
    dataType: 'json'
    dropZone: $('#photo-upload-div')
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]

  $('#photo-upload-div').click ->
    $('#fileupload').click()

  $('.tag').draggable(helper: 'clone')

  $('.photo').droppable(hoverClass: 'drop-highlight', drop: (evt, ui) ->
    $.post('home/tag', { tag: ui.helper.text(), filename: $(@).data('filename') })
  )