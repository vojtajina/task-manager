TASK_URL = 'https://www.googleapis.com/tasks/v1/lists/'

TM.factory 'Task', (authHttp) ->

  Task = (data) ->
    @status = 'needsAction'
    angular.extend @, data
    @


  Task.query = (taskListId) ->
    authHttp.get(TASK_URL + taskListId + '/tasks').then (response) ->
      response.data.items.map (item) ->
        new Task angular.extend(item, {listId: taskListId})


  Task.remove = (task) ->
    authHttp.remove(TASK_URL + task.listId + '/tasks/' + task.id)


  Task.save = (task) ->
    if task.id then authHttp.put(TASK_URL + task.listId + '/tasks/' + task.id, task).then (response) ->
      angular.extend task, response.data
    else authHttp.post(TASK_URL + task.listId + '/tasks', task).then (response) ->
      angular.extend task, response.data


  Task.prototype.$remove = ->
    Task.remove @


  Task.prototype.$save = ->
    Task.save @


  Task.prototype.$toggleCompleted = (task) ->
    if @status is 'completed'
      @status = 'needsAction'
      @completed = null
    else
      @status = 'completed'

    @$save()


  Task
