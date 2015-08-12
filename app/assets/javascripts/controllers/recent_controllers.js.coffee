JpgRanger.RecentPageController = JpgRanger.PhotoPagingController.extend()

JpgRanger.RecentPreviewController = JpgRanger.PhotoPreviewController.extend
  route_base_name: 'recent'
  query_params: null

JpgRanger.RecentFullController = JpgRanger.PhotoFullController.extend
  route_base_name: 'recent'
  query_params: null

