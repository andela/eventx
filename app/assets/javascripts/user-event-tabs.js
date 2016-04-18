$(document).ready(function () {
  $('#featured_tab').bind('click', function (event) {
    $('#featured_content').load('/featured_events', function () {
      $(this).scroll(500);
      $(this).scrollTop(300);
      $('#featured_content').hide();
      $(this).fadeIn(1000);
      $(this).unbind(event);
    });
  });
  $('#popular_tab').bind('click', function (event) {
    $('#popular_content').load('/popular_events', function () {
      $('#popular_content').hide();
      $(this).fadeIn(5000);
      $(this).unbind(event);
    });
  });
});
