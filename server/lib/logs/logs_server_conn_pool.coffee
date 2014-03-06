
class @LogsServerConnPool
  @logsConnPool: {}
  @addIfDoesntExist: (serverId, file)=>
    if @logsConnPool[serverId] and @logsConnPool[serverId][file]
      console.log "Connection for", serverId, file, " already exists..."
      if !_.contains @logsConnPool[serverId][file]['users'], Meteor.userId()
        @logsConnPool[serverId][file]['users'].push Meteor.userId()
    else
      console.log "Creating new Connection for", serverId, file, "..."
      conn = SSHConnection.getConnection serverId, file
      @logsConnPool[serverId] = {}
      @logsConnPool[serverId][file] = {}
      @logsConnPool[serverId][file]['connection'] = conn
      @logsConnPool[serverId][file]['users'] = [Meteor.userId()]

  @removeClient: (serverId, file)=>
    if @logsConnPool[serverId] and @logsConnPool[serverId][file]
      if _.contains @logsConnPool[serverId][file]['users'], Meteor.userId()
        @logsConnPool[serverId][file]['users'] = _.without @logsConnPool[serverId][file]['users'], Meteor.userId()


  @closeConnectionIfNoClients: (serverId, file)=>
    if @logsConnPool[serverId] and @logsConnPool[serverId][file]
      if _.size(@logsConnPool[serverId][file]['users']) == 0
        conn = @logsConnPool[serverId][file]['connection']
        conn.end()
        @logsConnPool[serverId][file] = null