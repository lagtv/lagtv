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

    $("[data-href]").click ->
      url = $(this).data("href")
      if(url.length > 0)
        location.href = url

$(document).ready ->
  Lagtv.init()
