TM = angular.module 'TM', []


# AUTH
CLIENT_ID = '522804721863.apps.googleusercontent.com'
SCOPES = [
  'https://www.googleapis.com/auth/tasks'
  'https://www.googleapis.com/auth/userinfo.profile'
]

window.onAuthLibLoad = ->
  authorize handleAuthResult, true

authorize = (callback, immediate) ->
  setTimeout ->
    window.gapi.auth.authorize {client_id: CLIENT_ID, scope: SCOPES, immediate: immediate}, callback


handleAuthResult = (authResult) ->
  if authResult and not authResult.error
    handleAuthorized authResult.access_token
  else
    status = document.querySelector 'h1.status'
    status.innerHTML = 'See blocked pop-up !'
    status.style.color = '#F00'

    authorize handleAuthResult, false

handleAuthorized = (token) ->
  TM.value 'ACCESS_TOKEN', token
  angular.bootstrap document, ['TM']
  
TM.config(['$httpProvider', ($httpProvider) ->
    delete $httpProvider.defaults.headers.common["X-Requested-With"]
])
