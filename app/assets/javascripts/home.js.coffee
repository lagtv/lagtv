jQuery ->
  $(".channel .arrow").click ->
    if $(".videos").data("status") != "animating"
      $(".videos").data("status", "animating")
      margin = parseInt($(".videos").css("marginLeft").replace("px", ""))
      offset = if $(@).hasClass("left") then -805 else 805
      new_margin = margin + offset
      if new_margin <= 0
        $(".videos").animate { marginLeft: "#{new_margin}px" }, ->
          $(".videos").data("status", "waiting")
      else
        $(".videos").data("status", "waiting")


#$(document).ready ->
#  $(".register").click (ev) ->
#    ev.stopPropagation()
#    $(".login_register_panel").load($(this).attr("href"))
#    return false