JpgRanger.Router.map ()->

  @route 'browse', { path: 'browse' }, ->
    @route 'preview', { path: 'preview/:id' }
    @route 'full', { path: 'full/:id' }
  @route 'collection', ->
    @route 'view', { path: ':collection_name' }

  @route 'stats'
