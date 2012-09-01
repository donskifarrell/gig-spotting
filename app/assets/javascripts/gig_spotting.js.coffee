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

    # temp data
    gigs.add({
      artist: 'Radiohead'
      location: 'London'
      markerLocation: ["51.505", "-0.09"]
    })
    gigs.add({
      artist: 'Blur'
      location: 'Belfast'
      details: 'mancs'
      markerLocation: ["51.505", "-0.01"]
    })
    gigs.add({
      location: 'Belfast'
      details: 'maaaaa'
      markerLocation: ["51.505", "-0.02"]
    })

    # Views
    new GigSpotting.Views.MapView({ model: map })
    new GigSpotting.Views.GigsView({ model: map, collection: gigs })
    new GigSpotting.Views.NavBarView

$(document).ready ->
  GigSpotting.init()
  $(window).resize()
