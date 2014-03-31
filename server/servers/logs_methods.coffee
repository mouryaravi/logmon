Meteor.methods
  getLogs: (params)->
    console.log 'Get logs for: ', params
    check(params.server, String)
    check(params.file, String)

    server = Servers.findOne _id: _s.trim(params.server)
    unless server
      throw new Meteor.Error 404, 'Can not find server', params.server
    LogsServerConnPool.addIfDoesntExist server, _s.trim(params.file)
    "Finished"

  stopLogs: (params)->
    console.log 'Stop logs for: ', params
    check(params.server, String)
    check(params.file, String)

    server = Servers.findOne _id: _s.trim(params.server)

    LogsServerConnPool.removeClient server, _s.trim(params.file)
    LogsServerConnPool.closeConnectionIfNoClients server, _s.trim(params.file)
    "Finished"