TASKLIST_URL = 'https://www.googleapis.com/tasks/v1/users/@me/lists'

TM.factory 'TaskList', (authHttp, Task) ->

  TaskList = (data) ->
    angular.extend @, data
    @$tasks = []
    @$tasksLoading = @$tasksLoaded = false
    @


  TaskList.query = ->
    authHttp.get(TASKLIST_URL).then (response) ->
      response.data.items.map (item) ->
        new TaskList item


  TaskList.save = (taskList) ->
    if taskList.id then authHttp.put(TASKLIST_URL + '/' + taskList.id, taskList).then (response) ->
      angular.extend taskList, response.data
    else authHttp.post(TASKLIST_URL, taskList).then (response) ->
      angular.extend taskList, response.data


  TaskList.remove = (taskList) ->
    authHttp.remove(TASKLIST_URL + '/' + taskList.id)


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
    @$tasks.splice @$tasks.indexOf(task), 1

    # destroy
    # TODO(vojta): handle failure
    task.$remove()


  TaskList
