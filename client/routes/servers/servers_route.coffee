Router.map ()->
  @route 'servers',
    path: '/servers'
    data: ()->
      serversList: Servers.find()

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

  @route 'newServer',
    path: '/newServer'
    data: ()->
      Servers.find
    loginRequired: 'login'
