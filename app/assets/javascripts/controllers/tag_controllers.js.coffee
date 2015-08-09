JpgRanger.TagPageController = JpgRanger.PhotoPagingController.extend

  tag: Ember.inject.controller()

  title: (->
    @get('tag.model.tag')
  ).property('tag.model.tag')
  photo_upload_data: (->
    { tag: @get('tag.model.tag') }
  ).property('tag.model.tag')

JpgRanger.TagPreviewController = JpgRanger.PhotoPreviewController.extend()
