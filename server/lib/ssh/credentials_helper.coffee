@CryptoJS = Meteor.require("crypto-js")

class @CredentialsHelper
  @getCredentials: (host) ->
    settings = Meteor.settings
    credentials = settings['credentials'];
    unless credentials
      throw new Meteor.Error 500, 'No credentials found in settings'
    creds = _.find credentials, (name, value) ->
      console.log 'Searching....', name, value, host
      _s.contains host, value
    username: creds.username, password: CryptoJS.AES.decrypt(creds.password, "f9fd664fb73377251f7f43c9cc7320a6").toString(CryptoJS.enc.Utf8)
