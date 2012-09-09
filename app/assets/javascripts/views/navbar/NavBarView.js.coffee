class GigSpotting.Views.NavBarView extends Backbone.View
	collection: GigSpotting.Collections.Gigs
	
	events:
		"submit": "searchGigs"

	initialize: ->
		$("#radius").combobox()

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
