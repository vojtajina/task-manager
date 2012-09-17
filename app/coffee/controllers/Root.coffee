TM.controller 'Root',  ($scope, TaskList, authHttp, Task, focusLastRow) ->
  $scope.taskLists = TaskList.query()

  # TODO(vojta): refactor to more controllers to get rid off using "this"
  $scope.toggle = (visible = !@tasksVisible) ->
    @tasksVisible = visible
    @list.$loadTasks()

  $scope.listIcon = ->
    if @tasksVisible then 'icon-chevron-down' else 'icon-chevron-right'

  $scope.remove = (task) ->
    if @confirmRemove then @list.$removeTask task else @confirmRemove = true

  $scope.confirmIcon = ->
    if @confirmRemove then 'confirm-remove' else ''

  $scope.addTask = ->
    @list.$tasks.unshift new Task {listId: @list.id}
    @toggle true
    focusLastRow()


  # load user info
  authHttp.get('https://www.googleapis.com/oauth2/v2/userinfo').success (data) ->
    $scope.user = data
