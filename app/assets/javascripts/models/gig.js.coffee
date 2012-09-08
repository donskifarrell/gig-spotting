class GigSpotting.Models.Gig extends Backbone.Model
	default:
		{
			artist: 'No Artist'
			gigName: 'This is a dummy gig - it\'s not real!'
			location: ["51.505", "-0.09"]
			date: '1/1/2013'
			imgSrc: 'path/to/image'
			matchRating: 'not sure if to be used. Maybe only direct match for triggering a visual clue.'
			details: 'This is a dummy gig - it\'s not real! So there are no details.'
			suportingActs: [
				{ name: 'Another artist' }
			]
		}

	# finds the closest ' ' after 20 characters and splits the string
	formatGigName: (gigName) ->
		maxLength = 20
		if gigName.length > maxLength 
			firstSpace = gigName.substring(maxLength).indexOf(" ")
			lhs = gigName.slice(0, maxLength + firstSpace)
			rhs = gigName.slice(maxLength + firstSpace)
			return lhs + '<br/>' + this.formatGigName(rhs)
		else
			return gigName


