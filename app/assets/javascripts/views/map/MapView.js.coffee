class GigSpotting.Views.MapView extends Backbone.View
	el: '#map'

	initialize: ->
		$(window).on('resize', this.resize)		
		this.render()

	render: ->		
		this.$(this.el).css('z-index', -100)
		this.initMap()

	initMap: (options) ->
		leafmap = this.model.get('leafMap')
		tiling = new L.TileLayer('http://{s}.tile.cloudmade.com/a84f13b2f3934d29b04ff6722e9492c3/997/256/{z}/{x}/{y}.png', 
		{
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>[…]',
			maxZoom: 18
		})
		london = new L.LatLng(51.505, -0.09)
		leafmap.setView(london, 13).addLayer(tiling)
		leafmap.on('popupopen', this.styleMarkerPopups);
		leafmap.addLayer(new L.Marker(["51.528" , "-0.13"]))

	styleMarkerPopups: ->
		$('.leaflet-popup-content-wrapper')
			.hover(
	            -> $(this).addClass("popup-hover"),
	            -> $(this).removeClass("popup-hover")
	        )

	resize: ->
		h = $(window).height()
		offsetTop = 60
		this.$(this.el).css('height', (h - offsetTop))

	remove: ->
		# unbind the namespaced event (to prevent accidentally unbinding some
		# other resize events from other code in your app
		# in jQuery 1.7+ use .off(...)
		$(window).off('resize')
		# don't forget to call the original remove() function
		Backbone.View.prototype.remove.call(this)
		# could also be written as:
		# this.constructor.__super__.remove.call(this);