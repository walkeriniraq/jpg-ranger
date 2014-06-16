class JpgRanger.ApplicationController extends Ember.Controller
  master_tags_list: []
  master_places_list: []
  master_people_list: []
  uploads_pending: 0

  init: ->
    $.ajax('/globals', dataType: 'json', cache: false).done (data) =>
      @master_tags_list.pushObjects data.tags
      @master_places_list.pushObjects data.places
      @master_people_list.pushObjects data.people

  has_uploads_pending: ~> @uploads_pending
