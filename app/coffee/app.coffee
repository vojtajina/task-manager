TM = angular.module 'TM', []


# AUTH
CLIENT_ID = '522804721863.apps.googleusercontent.com'
API_KEY = 'AIzaSyCGVpst99fnZjmNRaL3S5IYZdkUzGdHE40'
SCOPES = ['https://www.googleapis.com/auth/tasks', 'https://www.googleapis.com/auth/plus.me']

onAuthLibLoad = ->
  gapi.client.setApiKey API_KEY
  authorize handleAuthResult, true

authorize = (callback, immediate) ->
  setTimeout ->
    gapi.auth.authorize {client_id: CLIENT_ID, scope: SCOPES, immediate: immediate}, callback


handleAuthResult = (authResult) ->
  if authResult and not authResult.error
    console.log 'AUTHORIZED'
    angular.bootstrap document.body, ['TM']
  else
    authorize handleAuthResult, false



# bypass auth during development
onAuthLibLoad = -> null
TM.value 'ACCESS_TOKEN', 'ya29.AHES6ZRQndRAPfSD-_Z5jzbaoTPhhD8NBwZNxEiFEELKs3OsIcgnTA'
