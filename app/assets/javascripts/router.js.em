# For more information see: http://emberjs.com/guides/routing/

JpgRanger.Router.map ->
  @resource 'recent'
  @resource 'tag', { path: '/tag/:tag_name' }, ->
    @route 'preview', { path: '/preview/:id' }

