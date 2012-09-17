RESP_TASKLISTS = """
{
 "kind": "tasks#taskLists",
 "etag": "\\"M3V2EYzE8ZKSrA5JDxxyFB0Dbp4/2aASVHQttDAfsBp0bnXGx-IhTZY\\"",
 "items": [
  {
   "kind": "tasks#taskList",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MDow",
   "title": "Default List",
   "updated": "2012-09-16T20:33:10.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/users/@me/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MDow"
  },
  {
   "kind": "tasks#taskList",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6ODk2MDI4NzkxOjA",
   "title": "Google List",
   "updated": "2012-09-11T02:57:12.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/users/@me/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6ODk2MDI4NzkxOjA"
  },
  {
   "kind": "tasks#taskList",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTE4NTY1MTkzNzow",
   "title": "Car",
   "updated": "2012-09-07T07:35:50.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/users/@me/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTE4NTY1MTkzNzow"
  },
  {
   "kind": "tasks#taskList",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODow",
   "title": "Movies",
   "updated": "2012-09-16T07:06:25.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/users/@me/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MTgzNDE4MDY4ODow"
  }
 ]
}
"""

RESP_UPDATED_TASKLIST = """
{
   "kind": "tasks#taskList",
   "id": "MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MDow",
   "title": "Updated Title",
   "updated": "2012-09-16T20:33:10.000Z",
   "selfLink": "https://www.googleapis.com/tasks/v1/users/@me/lists/MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MDow"
  }
"""


describe 'model TaskList', ->

  $http = TaskList = flush = null

  beforeEach module 'TM', 'mocks.ACCESS_TOKEN'

  beforeEach inject (_TaskList_, $httpBackend, $rootScope) ->
    TaskList = _TaskList_
    $http = $httpBackend

    flush = ->
      $httpBackend.flush()
      $rootScope.$digest()


  describe 'query', ->

    it 'should return a promise with parsed items', ->
      $http.expectGET(TASKLIST_URL).respond RESP_TASKLISTS

      TaskList.query().then (items) ->
        expect(items.length).toBe 4
        expect(item instanceof TaskList).toBe(true) for item in items

      flush()


  describe '$save', ->

    it 'should do PUT on existing item', ->
      $http.expectPUT(TASKLIST_URL + '/fake-id').respond()

      list = new TaskList()
      list.id = 'fake-id'
      list.$save()

      flush()


    it 'should do POST on new item', ->
      $http.expectPOST(TASKLIST_URL).respond()

      list = new TaskList()
      list.title = 'some title'
      list.$save()

      flush()


    it 'should merge the response', ->
      $http.whenPOST(TASKLIST_URL).respond(RESP_UPDATED_TASKLIST)

      list = new TaskList()
      list.title = 'some title'
      list.$save()

      flush()
      expect(list.title).toBe 'Updated Title'
      expect(list.id).toBe 'MDMzOTE4NzU2NzI4Mjc5MDM3MzA6MDow'


  describe '$remove', ->

    it 'should do DELETE request', ->
      $http.expectDELETE(TASKLIST_URL + '/fake-id').respond()

      list = new TaskList()
      list.id = 'fake-id'
      list.$remove()

      flush()


  describe '$loadTasks', ->

    it 'should fetch related tasks', ->
      $http.expectGET(TASK_URL + 'list-id/tasks').respond RESP_TASKS

      list = new TaskList()

      expect(list.$tasksLoading).toBe false
      expect(list.$tasksLoaded).toBe false

      list.id = 'list-id'
      list.$loadTasks().then ->
        expect(list.$tasks.length).toBe 3
        expect(list.$tasksLoading).toBe false
        expect(list.$tasksLoaded).toBe true

        # should not fetch again, if already loaded
        list.$loadTasks()

      expect(list.$tasksLoading).toBe true
      expect(list.$tasksLoaded).toBe false

      # should not fetch again, if already loading
      list.$loadTasks()

      flush()


    it 'should preserve already added tasks', ->
      $http.expectGET(TASK_URL + 'list-id/tasks').respond RESP_TASKS

      list = new TaskList()
      fakeTask = {}

      list.$tasks.push fakeTask
      list.id = 'list-id'

      list.$loadTasks().then ->
        expect(list.$tasks.length).toBe 4
        expect(list.$tasks[0]).toBe fakeTask

      flush()


  describe '$removeTask', ->

    it 'should remove task from collection and call $remove()', ->
      list = new TaskList()
      fakeTask = {$remove: jasmine.createSpy '$remove'}

      list.$tasks.push fakeTask
      list.$removeTask fakeTask

      expect(fakeTask.$remove).toHaveBeenCalled()
      expect(list.$tasks).toEqual []
