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
    new GigSpotting.Views.MapView({ model: map })
    new GigSpotting.Views.NavBarView

$(document).ready ->
  GigSpotting.init()
  $(window).resize()
