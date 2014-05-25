# For more information see: http://emberjs.com/guides/routing/

JpgRanger.Router.map ->
  @resource 'recent'
  @resource 'tag', { path: '/tag/:tag_name' }, ->
    @route 'preview', { path: '/preview/:id' }
  @resource 'person', { path: '/person/:person_name' }, ->
    @route 'preview', { path: '/preview/:id' }
  @resource 'place', { path: '/place/:place_name' }, ->
    @route 'preview', { path: '/preview/:id' }

