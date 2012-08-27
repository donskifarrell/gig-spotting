window.GigSpotting =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (data) -> 
  	new GigSpotting.Models.Gig
  	new GigSpotting.Views.MapsIndex
  	new GigSpotting.Views.NavbarsIndex
  	new GigSpotting.Views.GigsIndex

$(document).ready ->
  GigSpotting.init('hihi')
  $(window).resize()
