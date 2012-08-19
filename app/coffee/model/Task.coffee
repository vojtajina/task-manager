TM.factory 'Task', (authHttp) ->
  URL = 'https://www.googleapis.com/tasks/v1/lists/'

  Task = (data) ->
    @status = 'needsAction'
    angular.extend @, data
    @


  Task.query = (taskListId) ->
    authHttp.get(URL + taskListId + '/tasks').then (response) ->
      response.data.items.map (item) ->
        new Task angular.extend(item, {listId: taskListId})


  Task.remove = (task) ->
    authHttp.remove(URL + task.listId + '/tasks/' + task.id)


  Task.save = (task) ->
    if task.id then authHttp.put(URL + task.listId + '/tasks/' + task.id, task).then (response) ->
      angular.extend task, response.data
    else authHttp.post(URL + task.listId + '/tasks', task).then (response) ->
      angular.extend task, response.data


  Task.prototype.$remove = ->
    Task.remove @


  Task.prototype.$save = ->
    Task.save @


  Task
