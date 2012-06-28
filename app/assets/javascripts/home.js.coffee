$(document).ready ->
  $(".register").click (ev) ->
    ev.stopPropagation()
    $(".login_register_panel").load($(this).attr("href"))
    return false