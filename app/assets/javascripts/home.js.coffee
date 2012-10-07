class Channel
  constructor: (selector) ->
    @animating = false
    @page_size = 805
    @current_page = 1
    @per_page = 6
    @selector = $(selector)
    @bind()

  bind: ->
    self = @
    @selector.find(".arrow").click ->
      self.move_left() if $(@).hasClass("left")
      self.move_right() if $(@).hasClass("right")

  go_to_start: ->
    @move_to 0
    @current_page = 1

  move_to: (offset) ->
    return if @animating
    @animating = true
    @selector.find(".videos").animate { marginLeft: "#{offset}px" }, 1000, "easeInOutCubic", =>
      @animating = false

  current_offset: ->
    return parseInt(@selector.find(".videos").css("marginLeft").replace("px", ""))

  move_left: ->
    return if @on_last_page() || @animating
    @move_to(@current_offset() - @page_size)
    @current_page++

  move_right: ->
    return if @on_first_page() || @animating
    @move_to(@current_offset() + @page_size)
    @current_page--

  total_pages: ->
    total = @selector.find(".videos .video_thumbnail").length
    return total / @per_page

  on_first_page: ->
    return @current_page == 1

  on_last_page: ->
    @current_page == @total_pages()

jQuery ->
  lagtv1 = new Channel(".lagtv1")
  lagtv2 = new Channel(".lagtv2")

  $(".tab").click ->
    current_channel = $(".tab.selected").data("channel")
    $(".inner-banner").removeClass($(".tab.selected").attr("id"))
    $(".#{current_channel}").hide()
    $(".tab").removeClass("selected")
    
    $(@).addClass("selected")
    channel = $(@).data("channel")
    $(".#{channel}").show()
    $(".inner-banner").addClass($(@).attr("id"))
