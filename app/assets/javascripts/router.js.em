# For more information see: http://emberjs.com/guides/routing/

JpgRanger.Router.map ->
  @resource 'recent', { path: '/' }, ->
    @route 'preview', { path: '/preview/:id' }
    @route 'full', { path: '/full/:id' }
  @resource 'tag', { path: '/tag/:tag_name' }, ->
    @route 'preview', { path: '/preview/:id' }
    @route 'full', { path: '/full/:id' }
  @resource 'person', { path: '/person/:person_name' }, ->
    @route 'preview', { path: '/preview/:id' }
    @route 'full', { path: '/full/:id' }
  @resource 'place', { path: '/place/:place_name' }, ->
    @route 'preview', { path: '/preview/:id' }
    @route 'full', { path: '/full/:id' }

