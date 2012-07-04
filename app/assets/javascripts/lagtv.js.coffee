$(document).ready ->
  $('textarea').each ->
    t = $(this).text()
    $(this).text($.trim(t))

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

  $(".new_topic textarea, .edit_topic textarea, .new_post textarea, .edit_post textarea").each ->
    new nicEditor(
      iconsPath : '/assets/nicEditorIcons.gif',
      buttonList : ['fontSize', 'bold', 'italic', 'underline', 'left', 'center', 'right', 'ul', 'strikethrough', 'indent', 'outdent', 'hr', 'image', 'forecolor', 'bgcolor', 'link', 'unlink']
    ).panelInstance(this.id)