Template.serverItem.events
  'click input[type=checkbox]': (event) ->
    console.log 'Checked ', event.target, $(event.target).is(':checked'), $(event.target).val(), $(event.target).attr('data-label')
    file = $(event.target).attr('data-label') + ":" + $(event.target).val()

    if $(event.target).is(':checked')
      selectedLogFiles = Session.get('selectedLogFiles') || []
      if !_.contains selectedLogFiles, file
        selectedLogFiles.push file
        Session.set 'selectedLogFiles', selectedLogFiles
    else
      selectedLogFiles = Session.get('selectedLogFiles') || []
      if _.contains selectedLogFiles, file
        selectedLogFiles = _.without selectedLogFiles, file
        Session.set 'selectedLogFiles', selectedLogFiles
        server = _s.strLeft file, ":"
        file = _s.strRight file, ":"
        s = Servers.findOne name: server, userId: Meteor.userId()

        Meteor.call 'stopLogs',
          server: s._id,
          file: file
          (err, status)->
            if err
              throw new Meteor.Error err.error, err.reason, err.details
            else
              console.log "Requested to stop logs...", status



