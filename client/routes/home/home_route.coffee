Router.map (params) ->
  @route 'home',
    path: '/'
    data: (params) ->
      serversList: Servers.find(userId: Meteor.userId())
