@Servers = new Meteor.Collection 'servers',
  schema: new SimpleSchema {
    name:
      type: String
      label: 'Server name'
      max: 200

    host:
      type: String
      label: 'Server hostname'
      max: 200

    port:
      type: Number
      label: 'Server port'
      max: 10
      optional: true
      autoValue: ()->
        22
    username:
      type: String
      label: 'Username to connect to server'
      max: 200
      optional: true

    password:
      type: String
      label: 'Password to connect to server'
      max: 512
      optional: true

    files:
      type: [String]
      label: 'Log files list'
      max: 20

    userId:
      type: String
      label: 'Server added by'
      max: 200
      denyUpdate: true

    createdAt:
      type: Date
      label: 'created at'
      denyUpdate: true
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