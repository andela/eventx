$(document).ready(function () {
  $(window).scroll(function () {
    var height = $('#content').height();
    var scroll = $(this).scrollTop();
    var win = $(window).height();
    var nav = $('.nav-wrapper').height();
    var height2 = height + 6 + nav - win;
    if (height !== null) {
      if (scroll - (height - win) >= 130) {
        $('#slide-out').css({
          'position': 'absolute',
          'bottom': '0',
          'margin-top': height2,
          'left': '0',
          'z-index': '-1'
        });
      } else {
        $('#slide-out').css({
          'position': 'fixed',
          'margin-top': '0',
          'z-index': '200'
        });
      }
    }
  });
  //this creates an animation for the scroll button at the bottom of the parallax
  setInterval(function () {
    $('.alert-scroll-under').animate({
      opacity: 0.1  // , height: "5%", width: "5%"
    }, 500);
    $('.alert-scroll-under').animate({
      opacity: 1  //, height: "2%", width: "2%"
    }, 500);
  }, 5);
});