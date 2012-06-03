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

    $(".suppress_click").click (ev) ->
      ev.stopPropagation()

    $(".bulk_download_replays").click (ev) ->
      ev.stopPropagation()
      querystring = "?"
      $("input.bulk_selection:checked").each ->
        querystring += "selected%5B%5D=" + $(this).val() + "&"
      
      if querystring.length > 1
        location.href = '/replays/download' + querystring

$(document).ready ->
  Lagtv.init()
