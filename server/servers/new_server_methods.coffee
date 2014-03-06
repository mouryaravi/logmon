Meteor.methods
  'addServer': (params)->
    console.log 'Adding server: ', params
    Servers.insert
      name: params.serverName
      host: params.host
      port: parseInt params.port, 10
      username: params.username
      password: params.password
      files: params.files.split(",")
