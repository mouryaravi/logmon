class @SSHConnection
  @getConnection : (serverId, file)->
    server = Servers.findOne serverId, file
    unless server
      throw new Meteor.Error 500, 'Wrong server Id: ' + serverId

    Connection = Meteor.require 'ssh2'
    conn = new Connection()

    conn.on 'ready', ()->
      console.log 'Connection ready for server: ', server.name, file

      conn.exec 'tail -f ' + file + '& read; kill $!', (err, stream)->
        if err
          throw new Meteor.Error 500, 'Error executing uptime', err

        stream.on 'end', ()->
          consle.log 'Stream End...'

        stream.on 'error', (err)->
          console.log 'Stream Error: ', err

        stream.on 'close', (had_error)->
          console.log 'Stream had error? ' + had_error + ", closing..."
          conn.end()

        stream.on 'data', (data, extended)->
          console.log (if extended == 'stderr' then 'STDERR: ' else 'STDOUT: '), 'received data: ', data.toString()
          Logs.update(
            {
              serverId: server._id
              file: file
            },
            {
              $set: {
                log: data.toString()
              }
            },
            {
              upsert: true
            }
          )
          log = Logs.findOne serverId: server._id, file: file
          console.log "the data: ", log

    conn.on 'error', (err)->
      console.log 'Connection error for server', server.name, ', Err: ', err

    conn.on 'end', ()->
      console.log 'Connection end for server', server.name

    conn.on 'close', (hadError)->
      console.log 'Connection closed for server', server.name


    conn.connect
      host: server.host
      port: server.port
      username: server.username
      password: server.password || @DEFAULT_PASSWORD


    console.log "Returning the connection...."
    conn

