TM = angular.module 'TM', []


# AUTH
CLIENT_ID = '522804721863.apps.googleusercontent.com'
SCOPES = [
  'https://www.googleapis.com/auth/tasks'
  'https://www.googleapis.com/auth/userinfo.profile'
]

onAuthLibLoad = ->
  authorize handleAuthResult, true

authorize = (callback, immediate) ->
  setTimeout ->
    gapi.auth.authorize {client_id: CLIENT_ID, scope: SCOPES, immediate: immediate}, callback


handleAuthResult = (authResult) ->
  if authResult and not authResult.error
    handleAuthorized authResult.access_token
  else
    authorize handleAuthResult, false

handleAuthorized = (token) ->
  TM.value 'ACCESS_TOKEN', token
  angular.bootstrap document, ['TM']
