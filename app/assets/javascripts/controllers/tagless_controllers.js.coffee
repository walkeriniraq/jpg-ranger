JpgRanger.TaglessPageController = JpgRanger.PhotoPagingController.extend()

JpgRanger.TaglessPreviewController = JpgRanger.PhotoPreviewController.extend
  route_base_name: 'tagless'
  query_params: { sans_tags: true }

JpgRanger.TaglessFullController = JpgRanger.PhotoFullController.extend
  route_base_name: 'tagless'
  query_params: { sans_tags: true }

