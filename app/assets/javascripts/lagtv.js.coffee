$(document).ready ->
  setInterval ->
    $(".twitch").load('/streams')
  , 60000 * 5

  $('textarea').each ->
    t = $(this).text()
    $(this).text($.trim(t))

  $('.dropdown-toggle').dropdown()
  
  $('.nav-tabs a').click (ev) ->
    e.preventDefault()
    $(this).tab('show')
  
  $('.nav-tabs a:first').tab('show')

  $('a[rel=tooltip]').tooltip()

  $("[data-href]").click (ev) ->
    return if ev.metaKey || ev.ctrlKey || ev.button == 1
    url = $(@).data("href")
    if(url.length > 0)
      new_tab = $(@).data("new_tab")
      if new_tab
        window.open url
      else
        location.href = url

  $(".suppress_click").click (ev) ->
    ev.stopPropagation()

  $('.rating').raty(
    readOnly : true,
    path: '/assets/',
    score: ->
      return $(this).attr('data-rating')
  )

  $(".new_topic textarea, .edit_topic textarea, .new_post textarea, .edit_post textarea, #user_signature, #user_about_me").each ->
    new nicEditor(
      iconsPath : '/assets/nicEditorIcons.gif',
      buttonList : ['fontSize', 'bold', 'italic', 'underline', 'left', 'center', 'right', 'ul', 'strikethrough', 'indent', 'outdent', 'hr', 'image', 'forecolor', 'bgcolor', 'link', 'unlink']
    ).panelInstance(this.id)

  $(".more").live 'click', ->
    more_link = $(@)
    url = more_link.attr("href")
    $.get url, (html) ->
      more_link.parent().append(html)
      more_link.remove()
      
      $('.rating').raty(
        readOnly : true,
        path: '/assets/',
        score: ->
          return $(this).attr('data-rating')
      )
    return false

  $(".replace").live 'click', ->
    url = $(@).data("url")
    $($(@).data('target')).load(url)
    return false    