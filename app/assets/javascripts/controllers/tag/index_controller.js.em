class JpgRanger.TagIndexController extends Ember.ArrayController
  needs: 'tag'
  preview_route: 'tag.preview'
  tag_name: ~> @controllers.tag.tag_name.charAt(0).toUpperCase() + @controllers.tag.tag_name.slice(1)
