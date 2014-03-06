Template.newServer.events
  'click button': (event)->
    event.preventDefault()
    console.log 'clicked on adding a server....'

    Meteor.call 'addServer',
      serverName:  $("#serverName").val()
      host:  $("#host").val()
      port: $("#port").val()
      username:  $("#username").val()
      password:  $("#password").val()
      files:  $("#files").val()
      (err, result)->
        if err
          throw new Meteor.Error err.error, err.reason
        else
          console.log 'Added new server', result
