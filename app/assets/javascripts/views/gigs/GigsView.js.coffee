class GigSpotting.Views.GigsView extends Backbone.View
	el: '.leaflet-popup-pane'

	initialize: ->
		_.bindAll(this)
		this.collection.bind('reset', this.reset)
		this.render()

	render: ->
		gigs = (this.generateMarker(gig) for gig in this.collection.models)
		this.gigsLayerGroup = L.layerGroup(gigs)
		this.model.get('leafMap').addLayer(this.gigsLayerGroup)

	generateMarker: (gig) ->
		gigRender =  new GigSpotting.Views.GigView({model: gig}).render()
		marker = new L.Marker(gig.get('markerLocation'))
		marker
			.bindPopup(gigRender)
			.on('mouseover', -> marker.openPopup())
		return marker

	reset: ->
		this.gigsLayerGroup.clearLayers()
		this.render()