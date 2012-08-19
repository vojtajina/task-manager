TM.directive 'contenteditable', (focusLastRow) ->
  require: '?ngModel'
  link: (scope, elm, attr, ngModel) ->
    if not ngModel then return

    # view -> model
    elm.bind 'blur', (e) ->
      scope.$apply -> ngModel.$setViewValue elm.html()

    # model -> view
    ngModel.$render = ->
      elm.html ngModel.$viewValue

    # trigger blur on enter
    elm.bind 'keypress', (e) ->
      if e.charCode is 13
        e.preventDefault()
        # loose focus trick (focus first <a> on the page)
        document.querySelectorAll('a')[0].focus()

    # add reference to last created contentEditable field
    # yep, super hackery... I know...
    focusLastRow.setElm elm
