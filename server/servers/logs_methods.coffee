Meteor.methods
  getLogs: (params)->
    console.log 'Get logs for: ', params

    LogsServerConnPool.addIfDoesntExist params.server, params.file
    "Finished"

  stopLogs: (params)->
    console.log 'Stop logs for: ', params
    LogsServerConnPool.removeClient params.server, params.file
    LogsServerConnPool.closeConnectionIfNoClients params.server, params.file
    "Finished"