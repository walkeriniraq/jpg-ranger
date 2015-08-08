#= require jquery
#= require jquery-ui-1.10.4
#= require jquery.iframe-transport
#= require jquery.fileupload
#= require moment
#= require bootstrap
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require jpg_ranger

$.ajaxSetup
  beforeSend: (jqXHR) ->
    jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

window.JpgRanger = Ember.Application.create(
  LOG_TRANSITIONS: true
)
