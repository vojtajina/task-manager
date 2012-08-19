TM.controller 'Root',  ($scope, TaskList, authHttp) ->
  $scope.taskLists = TaskList.query()

  $scope.toggle = ->
    @tasksVisible = !@tasksVisible
    @list.$loadTasks()

  $scope.listIcon = ->
    if @tasksVisible then 'icon-chevron-down' else 'icon-chevron-right'

  $scope.remove = (task) ->
    if @confirmRemove then @list.removeTask task else @confirmRemove = true

  $scope.confirmIcon = ->
    if @confirmRemove then 'confirm-remove' else ''

  # TODO(vojta): move to Task.$complete or $toggle
  $scope.complete = (task) ->
    if task.status is 'completed'
      task.status = 'needsAction'
      task.completed = null
    else
      task.status = 'completed'
    task.$save()

  # load user info
  authHttp.get('https://www.googleapis.com/oauth2/v2/userinfo').success (data) ->
    $scope.user = data
    console.log data
