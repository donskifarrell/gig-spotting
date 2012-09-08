window.GigSpotting =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    # Models
    map = new GigSpotting.Models.Map

    # Collections
    gigs = new GigSpotting.Collections.Gigs

    # Views
    new GigSpotting.Views.MapView({ model: map })
    new GigSpotting.Views.GigsView({ model: map, collection: gigs })
    new GigSpotting.Views.NavBarView({ el: $("#search_gigs"), collection: gigs })

$(document).ready ->
  GigSpotting.init()
  $(window).resize()
