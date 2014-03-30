@PersistentLogs = new Meteor.Collection 'persistentlogs',
  schema: new SimpleSchema {

    serverId:
      type: String
      label: 'Server Id'
      max: 200

    file:
      type: String
      label: 'Name of log file'
      max: 500
      optional: true

    log:
      type: String
      label: 'Actual log contents'

    createdAt:
      type: Date
      label: 'created at'
      autoValue: ()->
        if @isInsert then new Date()
        else if @isUpsert then {$setOnInsert: new Date()}
        else this.unset()

    lastUpdatedAt:
      type: Date
      label: 'Last Updated Time'
      autoValue: ()->
        if @isUpdate then new Date()
        else if @isInsert then new Date()
      optional: true

  }
