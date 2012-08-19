TM.service('authHttp', function($http, ACCESS_TOKEN) {
  var addAuthorizationTo = function(config) {
    config = config || {};
    config.headers = config.headers || {};
    config.headers['Authorization'] = 'Bearer ' + ACCESS_TOKEN;

    return config;
  };

  this.get = function(url, config) {
    return $http.get(url, addAuthorizationTo(config));
  };

  this.post = function(url, data, config) {
    return $http.post(url, data, addAuthorizationTo(config));
  };

  this.remove = function(url, config) {
    return $http['delete'](url, addAuthorizationTo(config));
  };
});
