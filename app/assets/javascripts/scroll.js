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
});
