$ ->
  $("a").live 'ajax:success', (event, xhr, status) ->
    $("#blog #container").html(xhr)
    Cufon.refresh()
    
    href = $(this).attr('href')
    $.address.value(href)