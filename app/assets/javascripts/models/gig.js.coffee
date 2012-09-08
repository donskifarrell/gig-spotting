class GigSpotting.Models.Gig extends Backbone.Model
	default:
		{
			artist: 'No Artist'
			gigName: 'This is a dummy gig - it\'s not real!'
			location: ["51.505", "-0.09"]
			date: '1/1/2013'
			matchRating: 'not sure if to be used. Maybe only direct match for triggering a visual clue.'
			details: 'This is a dummy gig - it\'s not real! So there are no details.'
			suportingActs: []
		}

	# finds the closest ' ' after 20 characters and splits the string
	formatDisplayName: ->
		if this.displayName.length < 20 
			return this.displayName
		else
			firstSpace = this.displayName.substring(20).indexOf(" ")
			lhs = this.displayName.slice(0, firstSpace)
			rhs = this.displayName.slice(firstSpace)
			return lhs + '<br/>' + rhs


