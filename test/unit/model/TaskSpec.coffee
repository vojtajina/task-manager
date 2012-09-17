RESP_TASKS = """
{
 "kind": "tasks#tasks",
 "etag": "\\"M3V2EYzE8ZKSrA5JDxxyFB0Dbp4/LTg0MDU0NjE5Mg\\"",
 "items": [
  {
   "kind": "tasks#task",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxOTIxNzY5MDYx",
   "etag": "\\"M3V2EYzE8ZKSrA5JDxxyFB0Dbp4/LTQwNzc2NTEzOQ\\"",
   "title": "Edit Piaf",
   "updated": "2012-09-16T07:06:25.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODow/tasks/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxOTIxNzY5MDYx",
   "position": "00000000002147483647",
   "status": "needsAction"
  },
  {
   "kind": "tasks#task",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxNDc5MTQyNzQ5",
   "etag": "\\"M3V2EYzE8ZKSrA5JDxxyFB0Dbp4/MTg4MTY5MDA3MA\\"",
   "title": "Dark Knight",
   "updated": "2012-03-11T00:51:44.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODow/tasks/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxNDc5MTQyNzQ5",
   "position": "00000000003221225471",
   "status": "needsAction"
  },
  {
   "kind": "tasks#task",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxODU5NDE1OTQ2",
   "etag": "\\"M3V2EYzE8ZKSrA5JDxxyFB0Dbp4/MTYwOTMyNzcyMw\\"",
   "title": "City of God",
   "updated": "2012-03-11T00:52:29.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODow/tasks/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODoxODU5NDE1OTQ2",
   "position": "00000000003758096383",
   "status": "needsAction"
  }
 ]
}
"""

describe 'model Task', ->

  $http = Task = null

  beforeEach inject (_Task_, $httpBackend) ->
    Task = _Task_
    $http = $httpBackend
