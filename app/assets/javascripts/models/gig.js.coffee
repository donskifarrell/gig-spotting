class GigSpotting.Models.Gig extends Backbone.Model
	default:
		{
			artist: 'Bjork'
			displayName: 'A really really good gig somewhere (a date)'
			markerLocation: ["51.505", "-0.09"]
			details: 'A crazy mofo'
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


