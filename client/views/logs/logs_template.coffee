Template.logsPane.helpers
  selectedLogFiles: ->
    Session.get 'selectedLogFiles'

  idHash: (id) ->
    CryptoJS.MD5(id).toString()

Template.logsPane.events
  'click .selectedLog': (event) ->
    event.preventDefault()
    target = $($(event.target)[0])
    console.log 'Clicked on ', target.text(), target.attr('href')
    $(target.attr('href')).tab('show')

    server = _s.strLeft target.text(), ":"
    file = _s.strRight target.text(), ":"
    s = Servers.findOne name: server, userId: Meteor.userId()

    needToCall = false
    fileSelected = Session.get target.text()
    unless fileSelected
      needToCall = true
      Session.set target.text(), true

    cursor = PersistentLogs.find serverId: s._id, file: _s.trim(file)
    if needToCall
      cursor.observe
        added: (log) ->
          console.log 'Got data....', log
          data = log.log.replace /\n/g, '<br />'
          $(target.attr('href')).append data;
        changed: (log) ->
          data = log.log.replace /\n/g, '<br />'
          console.log 'Updated data: ', data
          $(target.attr('href')).append data;
        removed: (log) ->
          console.log 'Removed data: ', log

      Meteor.call 'getLogs',
        server: s._id,
        file: file
        (err, status)->
          if err
            throw new Meteor.Error err.error, err.reason, err.details
          else
            console.log "Requested get logs...", status

