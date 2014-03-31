
class @LogsServerConnPool
  @logsConnPool: {}
  @addIfDoesntExist: (server, file)=>
    host = server.host
    console.log 'Connection pool: ', @logsConnPool

    if @logsConnPool[host] and @logsConnPool[host][file]
      console.log "Connection for", host, file, " already exists..."
      if !_.contains @logsConnPool[host][file]['users'], Meteor.userId()
        @logsConnPool[host][file]['users'].push Meteor.userId()
    else
      console.log "Creating new Connection for", host, file, "..."
      conn = SSHConnection.getConnection server, file
      unless @logsConnPool[host]
        @logsConnPool[host] = {}
      @logsConnPool[host][file] = {}
      @logsConnPool[host][file]['connection'] = conn
      @logsConnPool[host][file]['users'] = [Meteor.userId()]

  @removeClient: (server, file)=>
    host = server.host
    if @logsConnPool[host] and @logsConnPool[host][file]
      if _.contains @logsConnPool[host][file]['users'], Meteor.userId()
        @logsConnPool[host][file]['users'] = _.without @logsConnPool[host][file]['users'], Meteor.userId()


  @closeConnectionIfNoClients: (server, file)=>
    host = server.host
    if @logsConnPool[host] and @logsConnPool[host][file]
      if _.size(@logsConnPool[host][file]['users']) == 0
        conn = @logsConnPool[host][file]['connection']
        conn.end()
        @logsConnPool[host][file] = null