class JpgRanger.PersonRoute extends Ember.Route
  model: (params) ->
    @last_person_name = params.person_name.charAt(0).toUpperCase() + params.person_name.slice(1)
    @store.find 'photo', { person: params.person_name }

  setupController: (controller, model) ->
    @_super controller, model
    controller.person_name = @last_person_name