window.GigSpotting =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (data) -> 
  	# Collections
  	gigs = new GigSpotting.Collections.Gigs

  	# temp data
  	gigs.add({
  		artist: 'Radiohead'
  		location: 'London'
  		})
  	gigs.add({
  		artist: 'Blur'
  		location: 'Belfast'
  		details: 'mancs'
  		})
  	gigs.add({
  		location: 'Belfast'
  		details: 'maaaaa'
  		})

  	# Views
  	new GigSpotting.Views.MapsIndex({collection: gigs})
  	new GigSpotting.Views.NavbarsIndex
  	new GigSpotting.Views.GigsIndex

$(document).ready ->
  GigSpotting.init('hihi')
  $(window).resize()
