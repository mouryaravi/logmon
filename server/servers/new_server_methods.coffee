Meteor.methods
  addServer: (params)->
    console.log 'Adding server: ', params
    check(params.serverName, String)
    check(params.host, String)
    check(params.files, String)

    port = params.port || 22

    console.log 'inserting...'
    Servers.insert
      name: params.serverName
      host: params.host
      port: port
      files: params.files.split(",")
      userId: @userId
