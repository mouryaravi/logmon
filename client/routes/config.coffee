Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'



Router.before(
  ->
    user = Meteor.user()
    if !user
      @redirect if Meteor.loggingIn() then @loadingTemplate else 'login'
      @stop()
  ,
  except: ['login']
  )