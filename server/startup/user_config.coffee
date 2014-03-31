Meteor.startup ->

  settings = Meteor.settings
  unless settings and settings['credentials']
    console.log 'Specify Credentials in Meteor.settings'
    process.exit(1);
