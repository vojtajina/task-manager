TM.controller 'Root',  ($scope, TaskList) ->
  $scope.taskLists = TaskList.query()

  $scope.toggle = ->
    @tasksVisible = !@tasksVisible
    @list.$loadTasks()

  $scope.listIcon = ->
    if @tasksVisible then 'down' else 'right'

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
