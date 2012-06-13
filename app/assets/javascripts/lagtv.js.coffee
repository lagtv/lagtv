$(document).ready ->
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

  $('.rating').raty(
    readOnly : true,
    path: '/assets/',
    score: ->
      return $(this).attr('data-rating')
  )