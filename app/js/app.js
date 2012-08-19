var TM = angular.module('TM', []);

TM.value('ACCESS_TOKEN', 'ya29.AHES6ZQbUkRPWVr3jNb61dtTu58ydBMhikq5D1jCWO7loTtPncPzBQ');


// AUTH
var CLIENT_ID = '522804721863.apps.googleusercontent.com';
var API_KEY = 'AIzaSyCGVpst99fnZjmNRaL3S5IYZdkUzGdHE40';
var SCOPES = ['https://www.googleapis.com/auth/tasks', 'https://www.googleapis.com/auth/plus.me'];

var onAuthLibLoad = function() {
  return;
  gapi.client.setApiKey(API_KEY);
  authorize(handleAuthResult, true);
};

var authorize = function(callback, immediate) {
  setTimeout(function() {
    gapi.auth.authorize({client_id: CLIENT_ID, scope: SCOPES, immediate: immediate}, callback);
  });
};

var handleAuthResult = function(authResult) {
  if (authResult && !authResult.error) {
    console.log('AUTHORIZED')
    angular.bootstrap(document.body, ['TM']);
  } else {
    authorize(handleAuthResult, false);
  }
};
