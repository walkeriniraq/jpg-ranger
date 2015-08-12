JpgRanger.SmallestPageController = JpgRanger.PhotoPagingController.extend()

JpgRanger.SmallestPreviewController = JpgRanger.PhotoPreviewController.extend
  route_base_name: 'smallest'
  query_params: { by_size: true }

JpgRanger.SmallestFullController = JpgRanger.PhotoFullController.extend
  route_base_name: 'smallest'
  query_params: { by_size: true }

