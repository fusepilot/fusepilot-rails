$ ->
  $.address.state "/"
  
  Cufon.replace('h1, h2, h3, h4, h5, h6, .navigation', {
    hover: true
  });
  
  #$('#footer').stickyFooter
  
  $('input[type=text], input[type=email], textarea').each ->
    name = $(this).prev().text()
    $(this).attr('placeholder', name)

  
  