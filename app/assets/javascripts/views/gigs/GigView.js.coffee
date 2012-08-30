class GigSpotting.Views.GigView extends Backbone.View
	template: JST['gigs/index']

	render: ->
		this.$el.html(this.template(JSON.stringify(this.model)))

	addGig: (newGig) ->
		gig = new GigSpotting.Views.GigsIndex({model: newGig})
		this._GigViews[newGig.get('id')] = gig
		gig.render()

	renderGig: (gig) ->
		marker = new L.Marker(gig.markerLocation)
		marker
			.bindPopup(new GigSpotting.Views.GigsIndex({model: gig}).el)
			.on('mouseover', -> marker.openPopup())
		this.leafmap.addLayer(marker)