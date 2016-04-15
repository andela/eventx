$(document).ready(function () {
  $('.more-info').click(function () {
    //preventDefault();
    $('ul.tabs').tabs('select_tab', 'ticketing');
  });
  // $(".preview").click(function() {
  //   //preventDefault();
  //   $("ul.tabs").tabs("select_tab", "preview");
  // })
  var $navBar = $('.landing');
  var $navBar2 = $('.scroller');
  // on scroll
  $(window).scroll(function () {
    //// get scroll position from top of the page
    var scrollPos = $(this).scrollTop();
    if (scrollPos >= 80) {
      $navBar.addClass('fixer');
      $navBar2.addClass('scroll-fix');
      $('.before-scroll').show();
      $('.alert-scroll-under').hide();
    } else {
      $navBar.removeClass('fixer');
      $('.before-scroll').hide();
      $('.alert-scroll-under').show();
      $navBar2.removeClass('scroll-fix');
    }
  });
});
