TM.factory 'TaskList', (authHttp, Task) ->
  URL = 'https://www.googleapis.com/tasks/v1/users/@me/lists'

  TaskList = (data) ->
    angular.extend @, data
    @$tasks = []
    @$tasksLoading = @$tasksLoaded = false
    @


  TaskList.query = ->
    authHttp.get(URL).then (response) ->
      response.data.items.map (item) ->
        new TaskList item


  TaskList.save = (taskList) ->
    if taskList.id then authHttp.put(URL + '/' + taskList.id, taskList).then (response) ->
      angular.extend taskList, response.data
    else authHttp.post(URL, taskList).then (response) ->
      angular.extend taskList, response.data


  TaskList.remove = (taskList) ->
    authHttp.remove(URL + '/' + taskList.id)


  TaskList.prototype.$save = ->
    TaskList.save @


  TaskList.prototype.$remove = ->
    TaskList.remove @


  TaskList.prototype.$loadTasks = ->
    if not @$tasksLoaded and not @$tasksLoading
      @$tasksLoading = true

      Task.query(@id).then (tasks) =>
        @$tasks = @$tasks.concat tasks
        @$tasksLoading = false
        @$tasksLoaded = true


  TaskList.prototype.$removeTask = (task) ->
    # remove from collection
    idx = @$tasks.indexOf task
    @$tasks.splice idx, 1

    # destroy
    # TODO(vojta): handle failure
    task.$remove()



  TaskList
