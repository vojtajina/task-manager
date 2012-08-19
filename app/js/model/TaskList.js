TM.factory('TaskList', function($q, $rootScope, authHttp) {
  var URL = 'https://www.googleapis.com/tasks/v1/users/@me/lists';

  var TaskList = function(data) {
    angular.extend(this, data);
  };

  TaskList.query = function() {
    return authHttp.get(URL).then(function(response) {
      return response.data.items.map(function(item) {
        return new TaskList(item);
      });
    });
  };

  TaskList.create = function(taskList) {
    return authHttp.post(URL, taskList).then(function(response) {
      // TODO(vojta): update object with the response
      console.log(response);
    });
  };

  TaskList.remove = function(taskList) {
    return authHttp.remove(URL + '/' + taskList.id).then(function(response) {
      console.log(response);
    });
  };

  TaskList.prototype.$save = function() {};

  TaskList.prototype.$remove = function() {
    return TaskList.remove(this);
  };

  return TaskList;
});
