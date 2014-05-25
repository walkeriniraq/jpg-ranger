#$(document).on 'page:change', ->
#  $('#fileupload').fileupload
#    dataType: 'json'
#    dropZone: $('#photo-upload-div')
#    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]
#
#  $('#photo-upload-div').click ->
#    $('#fileupload').click()
#
#  $('.tag, .person, .place').draggable(helper: 'clone')
#
#  $('.photo').droppable(hoverClass: 'drop-highlight', drop: (evt, ui) ->
#    url = switch
#      when ui.draggable.hasClass('tag') then '/tag_photo'
#      when ui.draggable.hasClass('person') then '/tag_photo_person'
#      when ui.draggable.hasClass('place') then '/tag_photo_place'
#    $.post(url, { tag: ui.helper.text(), id: $(@).data('id') })
#  )
#
#  $('.new-tag-btn').click ->
#    ret = prompt('Type the value of the new tag')
#    return unless ret?
#    ret = ret.trim().toLowerCase()
#    if(ret.length < 1)
#      alert 'Please enter a value for the new tag'
#      return
#    $('.system-tag-container').append("<a href='/collection/tag/#{ ret }' class='tag label label-primary'>#{ret}</a>")
#    $('.tag:not(.ui-draggable)').draggable(helper: 'clone');
#
#  $('.new-place-btn').click ->
#    ret = prompt('What new place?')
#    return unless ret?
#    ret = ret.trim().toLowerCase()
#    if(ret.length < 1)
#      alert 'Please enter a value for the new place'
#      return
#    $('.system-place-container').append("<a href='/collection/place/#{ ret }' class='place label label-primary'>#{ret}</a>")
#    $('.place:not(.ui-draggable)').draggable(helper: 'clone');
#
#  $('.new-person-btn').click ->
#    ret = prompt('Who do you want to add?')
#    return unless ret?
#    ret = ret.trim().toLowerCase()
#    if(ret.length < 1)
#      alert 'Please enter a name for the person'
#      return
#    $('.system-person-container').append("<a href='/collection/person/#{ ret }' class='person label label-primary'>#{ret}</a>")
#    $('.person:not(.ui-draggable)').draggable(helper: 'clone');
#
#  $('.add-tag').click ->
#    elt = $(@)
#    $.post('/tag_photo', { tag: elt.data('tag'), id: $(@).data('id') }).done ->
#      $('.preview-tag-holder').append("<span class='label label-primary'>#{ elt.data('tag') }</span>")
#      elt.remove()
#
#  $('.preview-delete').click ->
#    ret = confirm 'Are you sure you want to delete this photo? This is permanent!'
#    return unless ret
#    $.post("/delete/#{$(@).data('id')}").done ->
#      console.log('OKAY')
#      location.href = '/'
#
#  $('.preview-new-tag').click ->
#    ret = prompt('Type the value of the new tag')
#    return unless ret?
#    ret = ret.trim().toLowerCase()
#    if(ret.length < 1)
#      alert 'Please enter a value for the new tag - tag not created'
#      return
#    $.post('/tag_photo', { tag: ret, id: $(@).data('id') }).done ->
#      $('.preview-tag-holder').append("<span class='label label-primary'>#{ ret }</span>")
#
