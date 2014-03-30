Template.home.helpers
  serversExist: (params) ->
    console.log 'finding servers count....', @serversList.count()
    @serversList.count() > 0
