class JpgRanger.PersonIndexController extends Ember.ArrayController
  needs: 'person'
  preview_route: 'person.preview'
  person_name: ~> @controllers.person.person_name
  person_name_display: ~> @person_name.charAt(0).toUpperCase() + @person_name.slice(1)
