Meteor.methods
  addServer: (params)->
    console.log 'Adding server: ', params
    check(params.serverName, String)
    check(params.host, String)
    check(params.files, String)

    port = params.port || 22
    files = params.files.split(",")
    idx = -1
    filesObjects = _.map files, (file) ->
      idx++
      { value : file, index: idx }

    console.log 'inserting...', filesObjects
    Servers.insert
      name: params.serverName
      host: params.host
      port: port
      files: filesObjects
      userId: Meteor.userId()
