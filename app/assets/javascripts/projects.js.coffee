total_width = 0
current_position = 0
previous_position = 0
$current_project = null
$previous_project = null

_window = null
_scroll = null
_body = null
_percent = 0

$ ->
  _window = $(window)
  _body = $("body")
  
  $(".project .gallery").hide()
  $(".project .container").hide()
  
  $(document).keypress (event) ->
    #console.log event.which
    switch event.which
      when 100
        if(current_position < 4)
          gotoProject(current_position + 1) ##right
      when 97 
        if(current_position > 0)
          gotoProject(current_position - 1) #left
      when 119
        prev = parseInt($current_project.css("margin-top"))
        $current_project.css("margin-top", prev - 10) #up
      when 115
        prev = parseInt($current_project.css("margin-top"))
        $current_project.css("margin-top", prev + 10) #down
   
  $(".projects .project").each (index) ->
    total_width += $(this).outerWidth(true)
  
  $(".projects").css("width", total_width)
    
  gotoProject(current_position, true)
  maximizeProjectMinimizeOthers(current_position, true)
  
  $(window).resize ->
    gotoProject(current_position, true)
  
  $(".image").click -> 
      new_position = $(this).parent().data("id")
      gotoProject(new_position)

  $(".toggle_container").click ->
    id = $(this).data("id")
    if id != current_position then gotoProject(id)
    showContainer(id)
    
  $(".toggle_gallery").click ->
    id = $(this).data("id")
    if id != current_position then gotoProject(id)
    showGallery(id)
    
  $("img").mousedown ->
    return false #disables image select and drag
  
maximizeProjectMinimizeOthers = (position, instant=false) ->
  maximizeProject(position, instant)
  $(".projects .project").each (index) ->
    if position != index then minimizeProject(index, instant)
  
maximizeProject = (position, instant=false) ->
  $project = getProject(position)
  time = if instant then 0 else 500
  $project.animate
    "width": 772
    "margin-top": 0
    time
    "easeInOutQuad"
  
  delay 500, ->
    showProjectTitleBar(position, instant)
    
minimizeProject = (position, instant=false) ->
  hideProjectTitleBar(position, instant)
  $project = getProject(position)
  time = if instant then 0 else 500
  hideGallery(position)
  $project.animate
    "width": 500
    "margin-top": 80
    time
    "easeInOutQuad"
    
getProject = (position) ->
  return $(".project[data-id=" + position + "]")

#resets a project by closing screenshots and content
reset = (position, instant=false) ->
  hideContainer(position, instant)
  hideGallery(position, instant)
  
showProjectTitleBar = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".project_info", $project).fadeIn(time)
    
hideProjectTitleBar = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".project_info", $project).fadeOut(time)
  
showContainer = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".container", $project).slideDown(time, "easeInOutQuad")
  
hideContainer = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".container", $project).slideUp(time, "easeInOutQuad")
    
showGallery = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".gallery", $project).slideDown(time, "easeInOutQuad")
  
hideGallery = (position, instant=false) ->
  time = if instant then 0 else 500
  $project = getProject(position)
  $(".gallery", $project).slideUp(time, "easeInOutQuad")

scrollTo = (value, instant=false) ->
  time = if instant then 0 else 500
  $('html, body').animate
    "scrollTop": value
    time
    "easeInOutQuad"
    
gotoProject = (position, instant=false) ->
  previous_position = current_position
  current_position = position
  $previous_project = getProject(previous_position)
  $current_project = getProject(current_position)
  
  showContainer(current_position, instant)
  maximizeProjectMinimizeOthers(current_position, instant)
  positionProjects(instant)
  scrollTo($(".projects").scrollTop() + 500)
  
  $($previous_project).unbind("mouseover").unbind("mouseout")
  
  $($current_project).bind "mouseover", () ->
    pageScrollToggle(false)
  $($current_project).bind "mouseout", () ->
    pageScrollToggle(true)
  
  #TODO clean up
  $($current_project).mousewheel (event, delta) ->
     current = $(this).css("margin-top")
     new_pos = parseInt(current) + (delta * 10)
     if new_pos > 0 then new_pos = 0 
     project_height = $(this).innerHeight()
     max_travel = project_height - 400 #TODO why 400?
     if new_pos < -max_travel then new_pos = -max_travel
     $(this).css("margin-top", new_pos)
     
pageScrollToggle = (enabled=true) ->
  if enabled
    $("body").css("overflow-y", "")
  else
    $("body").css("overflow-y", "hidden")


#positions the #project_slider container. centers on the currently selected project
positionProjects = (instant=false) ->
  time = if instant then 0 else 500
  
  window_width = $(window).width()
  window_height = $(window).height()
  project_width = $current_project.outerWidth(true)
  minimized_outerWidth = 564 #TODO smarten
  
  #calculate offset. talleys up minimzed projects for correct distance
  offset = (window_width * .5) - (792 * .5)
  if current_position > 0
    offset -= minimized_outerWidth * current_position
  
  $('.projects').animate
    "margin-left": offset
    time
    "easeInOutQuad"
      
delay = (ms, func) -> setTimeout func, ms