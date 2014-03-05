
class @LogsServerConnPool
  @logsConnPool: {}
  @addIfDoesntExist: (serverId, file)=>
    if @logsConnPool[serverId] and @logsConnPool[serverId][file]
      console.log "Connection for", serverId, file, " already exists..."
      return
    else
      console.log "Creating new Connection for", serverId, file, "..."
      conn = SSHConnection.getConnection serverId, file
      @logsConnPool[serverId] = {}
      @logsConnPool[serverId][file] = conn


