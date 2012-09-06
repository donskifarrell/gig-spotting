class GigSpotting.Views.GigsView extends Backbone.View
	el: '.leaflet-popup-pane'

	initialize: ->
		_.bindAll(this)
		this.collection.bind('reset', this.render)
		this.render()

	render: ->
		@self = this
		this.collection.each(this.addGigMarker)

	addGigMarker: (gig) =>
		this.model.get('leafMap').addLayer(this.generateMarker(gig))

	generateMarker: (gig) ->
		gigRender =  new GigSpotting.Views.GigView({model: gig}).render()
		marker = new L.Marker(gig.get('markerLocation'))
		marker
			.bindPopup(gigRender)
			.on('mouseover', -> marker.openPopup())
		return marker
