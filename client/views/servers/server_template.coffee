Template.server.events
  'click li .serverLog': (event)->
    event.preventDefault()
    Session.set 'selectedFile', $(event.target).text()
    console.log 'Clicked on', $(event.target).text()
    Meteor.call 'getLogs',
      server: Session.get('selectedServer'),
      file: $(event.target).text(),
      (err, status)->
        if err
          throw new Meteor.Error err.error, err.reason, err.details
        else
          console.log "Requested get logs...", status


Deps.autorun ()->
  console.log "Finding for ", Session.get("selectedServer"), ", file: ", Session.get("selectedFile")
  newLog = PersistentLogs.findOne
    serverId: Session.get('selectedServer')
    file: Session.get('selectedFile')

  if newLog
    data = newLog.log.replace /\n/g, '<br />'
    console.log 'Got new data....'
    $('.currentLogsDiv').append data