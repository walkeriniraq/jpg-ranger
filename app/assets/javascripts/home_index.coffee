$(document).on 'page:change', ->
  $('#fileupload').fileupload
    dataType: 'json'
    dropZone: $('#photo-upload-div')
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]

  $('#photo-upload-div').click ->
    $('#fileupload').click()

  $('.tag').draggable(helper: 'clone')

  $('.photo').droppable(hoverClass: 'drop-highlight', drop: (evt, ui) ->
    $.post('/tag_photo', { tag: ui.helper.text(), id: $(@).data('id') })
  )

  $('.new-tag-btn').click ->
    ret = prompt('Type the value of the new tag')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a value for the new tag - tag not created'
      return
    $('.system-tag-container').append("<a href='/collection/tag/#{ ret }' class='tag label label-primary'>#{ret}</a>")
    $('.tag:not(.ui-draggable)').draggable(helper: 'clone');

  $('.add-tag').click ->
    elt = $(@)
    $.post('/tag_photo', { tag: elt.data('tag'), id: $(@).data('id') }).done ->
      $('.preview-tag-holder').append("<span class='label label-primary'>#{ elt.data('tag') }</span>")
      elt.remove()

  $('.preview-delete').click ->
    ret = confirm 'Are you sure you want to delete this photo? This is permanent!'
    return unless ret
    $.post("/delete/#{$(@).data('id')}").done ->
      console.log('OKAY')
      location.href = '/'

  $('.preview-new-tag').click ->
    ret = prompt('Type the value of the new tag')
    return unless ret?
    ret = ret.trim().toLowerCase()
    if(ret.length < 1)
      alert 'Please enter a value for the new tag - tag not created'
      return
    $.post('/tag_photo', { tag: ret, id: $(@).data('id') }).done ->
      $('.preview-tag-holder').append("<span class='label label-primary'>#{ ret }</span>")

