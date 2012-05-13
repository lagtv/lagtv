window.Lagtv =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    $('.dropdown-toggle').dropdown()
    $('.nav-tabs a').click (e) ->
      e.preventDefault()
      $(this).tab('show')
    $('.nav-tabs a:first').tab('show')

$(document).ready ->
  Lagtv.init()
