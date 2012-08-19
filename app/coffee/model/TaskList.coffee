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


  TaskList.create = (taskList) ->
    authHttp.post(URL, taskList).then (response) ->
      # TODO(vojta): update object with the response
      console.log response


  TaskList.update = (taskList) ->
    authHttp.patch(URL + '/' + taskList.id).then (response) ->
      console.log response


  TaskList.remove = (taskList) ->
    authHttp.remove(URL + '/' + taskList.id).then (response) ->
      console.log response


  TaskList.prototype.$save = ->
    if this.id then TaskList.update(@) else TaskList.create(@)


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
