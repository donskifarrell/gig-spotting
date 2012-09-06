class GigSpotting.Views.NavBarView extends Backbone.View

	events:
		"submit": "searchGigs"

	initialize: ->
		$('.srchDate').datepicker()

	searchGigs: (e) ->
		console.log("search..")
		this.collection.fetch({ data: $(e.currentTarget).serialize() })
		return false

	getAttributes: (e) ->
		searchForm = $(e.currentTarget).serialize()
		console.log(searchForm)
		console.log(JSON.stringify(searchForm))
		return {
				artist: searchForm["song[artist]"],
				location: searchForm["song[artist]"]
			}
