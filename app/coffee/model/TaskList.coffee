TM.factory 'TaskList', (authHttp, Task) ->
  URL = 'https://www.googleapis.com/tasks/v1/users/@me/lists'

  TaskList = (data) ->
    angular.extend @, data
    @$tasks = null
    @$tasksLoading = false
    @


  TaskList.query = ->
    authHttp.get(URL).then (response) ->
      response.data.items.map (item) ->
        new TaskList item


  TaskList.save = (taskList) ->
    if taskList.id then authHttp.put(URL + '/' + taskList.id, taskList).then (response) ->
      console.log 'UPDATED', response
    else authHttp.post(URL, taskList).then (response) ->
      # TODO(vojta): update object with the response
      console.log 'CREATED', response


  TaskList.remove = (taskList) ->
    authHttp.remove(URL + '/' + taskList.id).then (response) ->
      console.log response


  TaskList.prototype.$save = ->
    TaskList.save @


  TaskList.prototype.$remove = ->
    TaskList.remove @


  TaskList.prototype.$loadTasks = ->
    if not @$tasks and not @$tasksLoading
      @$tasksLoading = true

      Task.query(@id).then (tasks) =>
        @$tasks = tasks
        @$tasksLoading = false



  TaskList.prototype.removeTask = (task) ->
    # remove from collection
    idx = @$tasks.indexOf task
    @$tasks.splice idx, 1

    # destroy
    # TODO(vojta): handle failure
    task.$remove()



  TaskList
