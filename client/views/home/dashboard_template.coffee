Template.menuPane.events
  'click .newServer': (event) ->
    event.preventDefault()
    Router.go 'newServer'

  'click .hidePanel': (event) ->
    event.preventDefault()
    if $(event.target).text() == "Hide"
      $("#servers-panel-body").hide()
      $(event.target).text("Show")
    else
      $("#servers-panel-body").show()
      $(event.target).text("Hide")

