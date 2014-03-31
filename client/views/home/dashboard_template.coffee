Template.menuPane.events
  'click .newServer': (event) ->
    event.preventDefault()
    Router.go 'newServer'