$(document).ready(function() {

  $('#beer').addClass('active')

  $('.container').on('click', 'h2', function() {
    if($(this).hasClass('active')) {
      // do nothing
    } else {
      $('.active').removeClass('active')
      $(this).parent().addClass('active')
    }
  })
})
