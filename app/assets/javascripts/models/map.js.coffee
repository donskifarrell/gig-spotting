class GigSpotting.Models.Map extends Backbone.Model
	initialize: ->
		this.set("leafMap", new L.Map('map'))