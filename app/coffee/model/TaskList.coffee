TM.factory 'TaskList', ($q, $rootScope, authHttp) ->
  URL = 'https://www.googleapis.com/tasks/v1/users/@me/lists'

  TaskList = (data) ->
    angular.extend this, data


  TaskList.query = ->
    authHttp.get(URL).then (response) ->
      response.data.items.map (item) ->
        new TaskList item


  TaskList.create = (taskList) ->
    authHttp.post(URL, taskList).then (response) ->
      # TODO(vojta): update object with the response
      console.log response


  TaskList.remove = (taskList) ->
    authHttp.remove(URL + '/' + taskList.id).then (response) ->
      console.log response


  # TaskList.prototype.$save = -> null

  TaskList.prototype.$remove = ->
    TaskList.remove this


  TaskList
