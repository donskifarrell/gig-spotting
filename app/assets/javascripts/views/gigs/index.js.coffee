class GigSpotting.Views.GigsIndex extends Backbone.View
  	template: JST['gigs/index']

	render: ->
		this.$el.html(this.template(this.model.toJSON()));
