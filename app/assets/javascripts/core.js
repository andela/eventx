$(document).ready(function () {
  $('.more-info').click(function () {
    //preventDefault();
    $('ul.tabs').tabs('select_tab', 'ticketing');
  });
  // $(".preview").click(function() {
  //   //preventDefault();
  //   $("ul.tabs").tabs("select_tab", "preview");
  // })
  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrain_width: false,
    // Does not change width of dropdown to that of the activator
    hover: false,
    // Activate on hover
    gutter: 0,
    // Spacing from edge
    belowOrigin: false  // Displays dropdown below the button
  });
  if (window.location.pathname != '/') {
    $('.our-custom-header').removeClass('before-scroll').css({ 'padding-top': '9px' });
  }
  $('select').material_select();
  $('.parallax').parallax();
  $('.modal-trigger').leanModal();
  $('.button-collapse').sideNav();
  $('.datepicker').pickadate({
    selectMonths: true,
    // Creates a dropdown to control month
    selectYears: 15  // Creates a dropdown of 15 years to control year
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
  // This is used to handle the create ticket session
  // of the first page of the create event page
  $('#free_ticket_btn').click(function () {
    $('#free_ticket_div').css('display', 'block');
    // Changes the create icon to teal
    $('#ticket_icon').css('color', '#26A79B');
  });
  $('#close_free').click(function () {
    $('#free_ticket_div').css('display', 'none');
  });
  $('#paid_ticket_btn').click(function () {
    $('#paid_ticket_div').css('display', 'block');
    // Changes the create icon to teal
    $('#ticket_icon').css('color', '#26A79B');
  });
  $('#close_paid').click(function () {
    $('#paid_ticket_div').css('display', 'none');
  });
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
  $('.file-uploader').click(function () {
    /* Act on the event */
    $('#event_photo_upload').trigger('click');
  });
  $('#event_photo_upload').change(function () {
    /* Act on the event */
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#index-banner').css('background', 'url(' + e.target.result + ')');
    };
    var uploaded_file = $(this)[0].files[0];
    reader.readAsDataURL(uploaded_file);
    $('.events_pic_name').html(uploaded_file.name);
  });
  //analytics
  (function (i, s, o, g, r, a, m) {
    i.GoogleAnalyticsObject = r;
    i[r] = i[r] || function () {
      (i[r].q = i[r].q || []).push(arguments);
    }, i[r].l = 1 * new Date();
    a = s.createElement(o), m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m);
  }(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga'));
  ga('create', 'UA-65653167-1', 'auto');
  ga('send', 'pageview');
  var event_date = $('.parallax-container').data('countdown');
  if (event_date) {
    countdown(convertDate(event_date));
  }
  // script for binding event details to preview page
  // var prev_color = "init";
  // var color = "";
  var prev_color = '';
  var color = '';
  $('.preview').click(function () {
    // if(prev_color=="init" || prev_color!=color){
    //   prev_color = color
    var start_date = $('#event_start_date').val();
    var end_date = $('#event_end_date').val();
    if (start_date) {
      countdown(convertDate(start_date), end_date);
    }
    var map_val = $('#event_map_url').val();
    var map;
    if (map_val) {
      map = map_val + '&output=embed';
    } else {
      map = 'https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb' + '&output=embed';
    }
    // description_selector = $("#event_description").val();
    var description_selector = $('#event_description').val() === '' ? 'Your Event description goes here<br/><br/><br/><br/>' : $('#event_description').val();
    var description = description_selector.length > 200 ? description_selector.substr(0, 200) + '...' : description_selector;
    var title = $('#event_title').val() === '' ? 'Event title goes here' : $('#event_title').val();
    $('.preview-tab').removeClass('disabled');
    $('ul.tabs').tabs('select_tab', 'preview');
    $('.preview-tab').addClass('disabled');
    $('.our-event-title').html(title);
    $('.our_event_description').html(description);
    $('.our-event-date').html(start_date + ' to ' + end_date);
    prev_color = color;
    color = $('input[name=\'event[event_template_id]\']:checked').attr('id') + ' darken-4';
    $('.landing2').removeClass(prev_color);
    $('.landing2').addClass(color);
    $('.our-event-map-url').attr({ 'src': map });
  });
  $('#edit-event').click(function () {
    var event_id = $(this).data('eventid');
    // console.log(event_id)
    $('#content').load('/events/' + event_id + '/edit');
  });
});
/* Every time the window is scrolled ... */

