class GigSpotting.Views.GigView extends Backbone.View
  	template: JST['gigs/index']

	render: ->
		this.$el.html(this.template(this.model.toJSON()));
