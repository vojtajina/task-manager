TM.directive 'contenteditable', (focusLastRow) ->
  require: '?ngModel'
  link: (scope, elm, attr, ngModel) ->
    if not ngModel then return

    triggerBlur = ->
      # loose focus trick (focus first <a> on the page)
      document.querySelectorAll('a')[0].focus()

    # view -> model
    elm.bind 'blur', (e) ->
      scope.$apply -> ngModel.$setViewValue elm.html()

    # model -> view
    ngModel.$render = ->
      elm.html ngModel.$viewValue

    # trigger blur on esc, but cancel change
    elm.bind 'keyup', (e) ->
      if e.keyCode is 27
        elm.html ngModel.$viewValue
        triggerBlur()

    # trigger blur on enter
    elm.bind 'keypress', (e) ->
      if e.charCode is 13
        e.preventDefault()
        triggerBlur()

    # add reference to last created contentEditable field
    # yep, super hackery... I know...
    focusLastRow.setElm elm
