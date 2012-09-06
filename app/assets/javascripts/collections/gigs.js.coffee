class GigSpotting.Collections.Gigs extends Backbone.Collection
	model: GigSpotting.Models.Gig
	url: '/search'

	initialize: ->
		this.on('add', this.onAdd)
		this.on('change', this.onChange)

	onAdd: (gig) ->
		#alert 'New artist: ' + gig.get('artist')

	onChange: ->
		alert 'Number of gigs: ' + this.models.length
		# If number=0, then display popup saying no artists found
