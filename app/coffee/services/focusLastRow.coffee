TM.factory 'focusLastRow', ->
  lastRow = null

  focus = ->
    setTimeout (-> if lastRow then lastRow.focus()), 0

  focus.setElm = (jqElm) ->
    lastRow = jqElm[0]

  focus
