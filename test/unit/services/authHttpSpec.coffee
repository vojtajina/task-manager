describe 'services authHttp', ->
  http = authHttp = null

  beforeEach module 'TM', ($provide) ->
    $provide.value 'ACCESS_TOKEN', '<TOKEN>'
    null

  beforeEach inject ($httpBackend, _authHttp_) ->
    http = $httpBackend
    authHttp = _authHttp_


  describe 'get', ->

    it 'should add Authorization header', ->
      assertHeaders = (headers) ->
        headers.Authorization is 'Bearer <TOKEN>'

      http.expectGET('/some', assertHeaders).respond()
      authHttp.get '/some'


    it 'should preserve original headers', ->
      assertHeaders = (headers) ->
        headers.Authorization is 'Bearer <TOKEN>' and headers.some is 'header'

      http.expectGET('/some', assertHeaders).respond()
      authHttp.get '/some', {headers: {some: 'header'}}


  describe 'post', ->

    it 'should add Authorization header', ->
      assertHeaders = (headers) ->
        headers.Authorization is 'Bearer <TOKEN>'

      http.expectPOST('/some', null, assertHeaders).respond()
      authHttp.post '/some'


    it 'should preserve original headers', ->
      assertHeaders = (headers) ->
        headers.Authorization is 'Bearer <TOKEN>' and headers.some is 'header'

      http.expectPOST('/some', null, assertHeaders).respond()
      authHttp.post '/some', null, {headers: {some: 'header'}}


    it 'should forward data', ->
      assertHeaders = (headers) ->
        headers.Authorization is 'Bearer <TOKEN>' and headers.some is 'header'

      http.expectPOST('/some', {title: 'Whatever'}).respond()
      authHttp.post '/some', {title: 'Whatever'}
