Meteor.methods
  'getLogs': (params)->
    console.log 'Got params: ', params

    LogsServerConnPool.addIfDoesntExist params.server, params.file
    "Finished"