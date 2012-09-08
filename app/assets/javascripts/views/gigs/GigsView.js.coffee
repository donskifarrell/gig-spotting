class GigSpotting.Views.GigsView extends Backbone.View
	el: '.leaflet-popup-pane'

	initialize: ->
		_.bindAll(this)
		this.collection.bind('reset', this.reset)
		this.render()

	render: ->
		gigs = (this.generateGigs(artist) for artist in this.collection.models)
		this.gigsLayerGroup = L.layerGroup(flatten(gigs))
		this.model.get('leafMap').addLayer(this.gigsLayerGroup)

	generateGigs: (artist) ->		
		markers = (this.generateMarker(gig) for gig in artist.get('events'))
		return markers

	generateMarker: (gig) ->
		gigRender =  new GigSpotting.Views.GigView({model: gig}).render()
		marker = new L.Marker(gig.markerLocation)
		marker
			.bindPopup(gigRender)
			.on('mouseover', -> marker.openPopup())
		return marker

	reset: ->
		this.gigsLayerGroup.clearLayers()
		this.render()

	flatten = (a) ->
	    if a.length is 0 then return []
	    a.reduce (lhs, rhs) -> lhs.concat rhs