$(window).scroll(function () {
  /* Check the location of each desired element */
  $('.hideme').each(function () {
    var bottom_of_object = $(this).offset().top + $(this).outerHeight();
    var bottom_of_window = $(window).scrollTop() + $(window).height();
    /* If the object is completely visible in the window, fade it in */
    if (bottom_of_window > bottom_of_object) {
      $(this).animate({ 'opacity': '1' }, 300);
    }
  });
});