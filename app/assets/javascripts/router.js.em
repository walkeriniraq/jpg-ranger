JpgRanger.Router.map ->
  @resource 'recent', { path: 'recent' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
  @route 'recent.full', { path: 'recent/full/:id' }

  @resource 'person', { path: 'person/:person_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
  @route 'person.full', { path: 'person/:person_name/full/:id' }

  @resource 'place', { path: 'place/:place_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
  @route 'place.full', { path: 'place/:place_name/full/:id' }

  @resource 'tag', { path: 'tag/:tag_name' }, ->
    @route 'page', { path: ':page'}
    @route 'preview', { path: 'preview/:id' }
  @route 'tag.full', { path: 'tag/:tag_name/full/:id' }

