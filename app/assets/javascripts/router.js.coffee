JpgRanger.Router.map ()->
  @resource 'recent', { path: 'recent' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'smallest', { path: 'smallest' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'tagless', { path: 'tagless' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'person', { path: 'person/:person_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'place', { path: 'place/:place_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'tag', { path: 'tag/:tag_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @resource 'collection', { path: 'collection/:collection_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }

  @route 'stats'