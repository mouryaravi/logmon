#Meteor.publish 'log', (server)->
#  Logs.find
#    serverId: server


updateExistingLog = (newLog)->
  PersistentLogs.update(
    {
      serverId: newLog.serverId
      file: newLog.file
    },
    {
      $set: {
        log: newLog.log
      }
    },
    {
      upsert: true
    }
  )

logsCursor = Logs.find()
logsCursor.observe
  added: (doc, beforeIndex)->
    oldLog = PersistentLogs.findOne serverId: doc.serverId, file: doc.file
    if oldLog
      updateExistingLog(doc)
    else
      PersistentLogs.insert doc

  changed: (newDoc, atIndex, oldDoc)->
    updateExistingLog(newDoc)