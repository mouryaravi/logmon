Meteor.startup ->
  user = Meteor.users.findOne
    username: 'ravi@pentaur.com'
  unless user
    Meteor.users.insert
      username: 'ravi@pentaur.com'
      emails: [
        address: 'ravi@pentaur.com', verified: true
      ]
      createdAt: new Date()
      profile:
        name: 'Ravi Laudya'

    console.log 'Added user...'
    user = Meteor.users.findOne
      username: 'ravi@pentaur.com'

    Accounts.setPassword user._id, 'xyz123#'
