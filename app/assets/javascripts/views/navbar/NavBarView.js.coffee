class GigSpotting.Views.NavBarView extends Backbone.View

	events:
		"submit": "searchGigs"

	initialize: ->
		$('.srchDate').datepicker()

	searchGigs: (e) ->
		e.preventDefault()		
		console.log("seara")