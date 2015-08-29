JpgRanger.PhotoGridComponent = Ember.Component.extend
  last_selected_photo: null

  actions:
    change_page: (page) ->
      @get('selected_photos').clear()
      @sendAction('change_page', page)

    select_photo: (photo) ->
      @get('selected_photos').clear().pushObject(photo)
      @set 'last_selected_photo', photo

    toggle_selection: (photo) ->
      selected = @get('selected_photos')
      if selected.contains(photo)
        selected.removeObject photo
      else
        selected.pushObject photo
        @set 'last_selected_photo', photo

    range_select: (photo) ->
      unless @get('last_selected_photo')?
        @set 'last_selected_photo', photo
        return

      in_select_range = false
      @get('photos').forEach (x) =>
        if in_select_range
          @get('selected_photos').pushObject(x)
          if x == @get('last_selected_photo') or x == photo
            in_select_range = false
        else
          if x == @get('last_selected_photo') or x == photo
            in_select_range = true
            @get('selected_photos').pushObject(x)

  total_pages: (->
    @get 'photos.meta.total_pages'
  ).property('photos.meta.total_pages')
  current_page: (->
    @get 'photos.meta.page'
  ).property('photos.meta.page')
  has_next_page: (->
    @get('current_page') < @get('total_pages')
  ).property('current_page', 'total_pages')
  has_previous_page: (->
    @get('current_page') > 1
  ).property('current_page')
  next_page: (->
    @get('current_page') + 1
  ).property('current_page')
  previous_page: (->
    @get('current_page') - 1
  ).property('current_page')
