class GigSpotting.Views.GigsView extends Backbone.View
	el: '.leaflet-popup-pane'
	collection: GigSpotting.Collections.Gigs

	initialize: ->
		_.bindAll(this)
		this.collection.bind('reset', this.reset)
		this.render()

	render: ->
		if this.collection.models == undefined then return
		gigs = (this.generateMarker(gig) for gig in this.collection.models)
		this.gigsLayerGroup = L.layerGroup(gigs)
		this.model.get('leafMap').addLayer(this.gigsLayerGroup)

	generateMarker: (gig) ->
		gigRender =  new GigSpotting.Views.GigView({model: gig}).render()
		marker = new L.Marker(gig.get('location'))
		marker
			.bindPopup(gigRender)
			.on('mouseover', -> marker.openPopup())
		return marker

	reset: ->
		this.gigsLayerGroup.clearLayers()
		this.render()
