Template.server.helpers
  filesArrayWithIndex: ()->
    console.log 'Files: ', @files
    _.map @files, (file)->
      {index: CryptoJS.MD5(file).toString(), file: file}


Template.server.events
  'click li .serverLog': (event)->
    event.preventDefault()
    needToCall = false
    newFileId = CryptoJS.MD5($(event.target).text()).toString()
    selectedFiles = Session.get('selectedFiles') || {}

    unless selectedFiles[newFileId]
      needToCall = true

    selectedFiles[newFileId] = $(event.target).text()
    Session.set 'selectedFiles', selectedFiles
    console.log 'Clicked on', $(event.target).text()
    $(event.target).tab('show')

    if needToCall
      Meteor.call 'getLogs',
        server: Session.get('selectedServer'),
        file: $(event.target).text(),
        (err, status)->
          if err
            throw new Meteor.Error err.error, err.reason, err.details
          else
            console.log "Requested get logs...", status

  'click li button': (event)->
    event.preventDefault()
    console.log 'Removing server, file', Session.get("selectedServer"), @file
    Meteor.call 'stopLogs',
      server: Session.get('selectedServer'),
      file: @file
      (err, status)->
        if err
          throw new Meteor.Error err.error, err.reason, err.details
        else
          console.log "Requested to stop logs...", status


Deps.autorun ()->
  console.log "Finding for ", Session.get("selectedServer"), ", files: ", Session.get("selectedFiles")
  selectedFiles = Session.get 'selectedFiles'
  if _.size(selectedFiles) > 0
    _.each selectedFiles, (key, file)->
      console.log 'Finding for ....', key, file
      newLog = Logs.findOne
        serverId: Session.get('selectedServer')
        file: key
      if newLog
        data = newLog.log.replace /\n/g, '<br />'
        console.log 'Got new data....'
        $('#' + file).append data
