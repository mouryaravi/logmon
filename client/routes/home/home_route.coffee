Router.map ()->
  @route 'home',
    path: '/'
    data: ()->
      serversList: Servers.find()