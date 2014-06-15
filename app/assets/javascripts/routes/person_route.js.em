class JpgRanger.PersonRoute extends Ember.Route
  model: (params) ->
    { person: params.person_name }

class JpgRanger.PersonIndexRoute extends Ember.Route
  redirect: (params) ->
    @transitionTo 'person.page', params.person, 1

class JpgRanger.PersonPageRoute extends JpgRanger*.BasePhotoPagingRoute
  setupController: (controller, model) ->
    super(controller, model)
    person = @parent_model().person
    controller.title = person
    controller.preview_route = 'person.preview'
    controller.photo_upload_data = { person: person }

  actions:
    change_page: (page) ->
      @transitionTo 'person.page', @parent_model().person, page

class JpgRanger.PersonPreviewRoute extends JpgRanger*.BasePhotoPreviewRoute
  actions:
    open_full: (photo) ->
      @transitionTo('person.full', @parent_model().person, photo.id)

class JpgRanger.PersonFullRoute extends JpgRanger*.BasePhotoFullRoute
