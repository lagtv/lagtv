$ ->
  $(".add_selected_service").click ->
    id = $("#service").val()
    url = $(@).data("url")
    $.get "#{url}?service_id=#{id}", (html) ->
      $(".services").append(html)      
    false

  $('.services').on 'click', '.remove_service', (event) ->
    $(@).closest('.service').find('input[type=hidden]').val('1')
    $(@).closest('.service').fadeOut()
    event.preventDefault()

  $('.report_profile').click ->
    $('.report_profile_form').toggle()
    false