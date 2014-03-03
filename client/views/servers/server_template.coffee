Template.server.events
  'click li .serverLog': (event)->
    event.preventDefault()
    Session.set 'selectedFile', $(event.target).text()
    console.log 'Clicked on', $(event.target).text()
    Meteor.call 'getLogs',
      server: Session.get('selectedServer'),
      file: $(event.target).text()


Deps.autorun ()->
  console.log "Finding for ", Session.get("selectedServer"), ", file: ", Session.get("selectedFile")
  newLog = Logs.findOne
    serverId: Session.get('selectedServer')
    file: Session.get('selectedFile')

  console.log "New log", newLog
  if newLog
    console.log 'Got new data: ', newLog.log