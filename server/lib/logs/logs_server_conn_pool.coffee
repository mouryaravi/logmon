class @LogsServerConnPool
  @pool = {}

  @addIfDoesntExist: (serverId, file)->
    if @pool[serverId] and @pool[serverId][file]
      return
    wrappedGetConnection = Async.wrap SSHConnection.getConnection

    conn = wrappedGetConnection serverId, file
    @pool[serverId] = {}
    @pool[serverId][file] = conn


