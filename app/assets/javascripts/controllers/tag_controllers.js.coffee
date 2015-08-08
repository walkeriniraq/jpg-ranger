JpgRanger.TagPageController = JpgRanger.PhotoPagingController.extend
  needs: 'tag'
  title: (->
    @get('controllers.tag.model.tag')
  ).property('controllers.tag.model.tag')
  photo_upload_data: (->
    { tag: @get('controllers.tag.model.tag') }
  ).property('controllers.tag.model.tag')

JpgRanger.TagPreviewController = JpgRanger.PhotoPreviewController.extend()
