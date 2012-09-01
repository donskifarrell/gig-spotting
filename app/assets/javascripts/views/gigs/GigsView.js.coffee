class GigSpotting.Views.GigsView extends Backbone.View
	el: '.leaflet-popup-pane'
	
	events:
		"dblclick": "open"

	initialize: ->
		_(this).bindAll('add');
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

	add: (model) ->
		alert "Addededeed"
		this.render()