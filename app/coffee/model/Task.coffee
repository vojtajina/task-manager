TM.factory 'Task', (authHttp) ->
  URL = 'https://www.googleapis.com/tasks/v1/lists/'

  Task = (data) ->
    angular.extend @, data

  Task.query = (taskListId) ->
    authHttp.get(URL + taskListId + '/tasks').then (response) ->
      console.log response.data.items
      response.data.items.map (item) ->
        new Task item


  # TODO(vojta): use taskListId instead of selfLink
  Task.remove = (task) ->
    authHttp.remove(task.selfLink).then (response) ->
      console.log response


  Task.update = (task) ->
    authHttp.put(task.selfLink, task).then (response) ->
      console.log response



  Task.prototype.$remove = ->
    Task.remove @


  Task.prototype.$save = ->
    Task.update @


  Task
