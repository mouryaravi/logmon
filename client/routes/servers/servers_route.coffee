Router.map ()->
  @route 'server',
    path: '/server/:_id'
    data: ()->
      Servers.findOne @params._id
    loginRequired: 'login'
    load: ()->
      Session.set 'selectedServer', @params._id
    unload: ()->
      Session.set 'selectedServer', ''
      Session.set 'selectedFile', ''
#    waitOn: ()->
#      [
#        Meteor.subscribe 'log', @params._id
#      ]