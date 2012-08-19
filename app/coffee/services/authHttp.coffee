TM.service 'authHttp', ($http, ACCESS_TOKEN) ->

  addAuthorizationTo = (config = {}) ->
    config.headers = config.headers or {}
    config.headers['Authorization'] = 'Bearer ' + ACCESS_TOKEN
    config

  @get = (url, config) -> $http.get url, addAuthorizationTo config
  @post = (url, data, config) -> $http.post url, data, addAuthorizationTo config
  @remove = (url, config) -> $http['delete'] url, addAuthorizationTo config
  @put = (url, data, config) -> $http.put url, data, addAuthorizationTo config
