JpgRanger.TagPageController = JpgRanger.PhotoPagingController.extend
  tag: Ember.inject.controller()

  title: (->
    @get('tag.model.tag')
  ).property('tag.model.tag')
  photo_upload_data: (->
    { tag: @get('tag.model.tag') }
  ).property('tag.model.tag')

JpgRanger.TagPreviewController = JpgRanger.PhotoPreviewController.extend
  tag: Ember.inject.controller()

  route_base_name: 'tag'
  query_params: Ember.computed('tag.model.tag', -> { tag: @get('tag.model.tag') })

JpgRanger.TagFullController = JpgRanger.PhotoFullController.extend
  tag: Ember.inject.controller()

  route_base_name: 'tag'
  query_params: Ember.computed('tag.model.tag', -> { tag: @get('tag.model.tag') })
