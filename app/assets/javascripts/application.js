// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require_tree .

$(document).ready(function() {
  $(".more-info").click(function() {
    //preventDefault();
    $('ul.tabs').tabs('select_tab', 'test2');
  })
  $(".preview").click(function() {
    //preventDefault();
    $('ul.tabs').tabs('select_tab', 'test3');
  })

  google.maps.event.addDomListener(window, 'load', initialize);

  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrain_width: false, // Does not change width of dropdown to that of the activator
    hover: false, // Activate on hover
    gutter: 0, // Spacing from edge
    belowOrigin: false // Displays dropdown below the button
  });

  if (window.location.pathname != '/') {
    $('.our-custom-header').removeClass('before-scroll').css({
      'padding-top': '9px'
    });
  }

  $('select').material_select();
  $('.parallax').parallax();
  $('.modal-trigger').leanModal();
  $(".button-collapse").sideNav();

  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });

  //this creates an animation for the scroll button at the bottom of the parallax
  setInterval(function() {
    $('.alert-scroll-under').animate({
      opacity: 0.1 // , height: '5%', width: '5%'
    }, 500);
    $('.alert-scroll-under').animate({
      opacity: 1 //, height: '2%', width: '2%'
    }, 500);
  }, 5);

  // This is used to handle the create ticket session
  // of the first page of the create event page
  $('#free_ticket_btn').click(function() {
    $("#free_ticket_div").css("display", "block");
    // Changes the create icon to teal
    $("#ticket_icon").css("color", "#26A79B");
  });
  $('#close_free').click(function() {
    $("#free_ticket_div").css("display", "none");
  });

  $('#paid_ticket_btn').click(function() {
    $("#paid_ticket_div").css("display", "block");
    // Changes the create icon to teal
    $("#ticket_icon").css("color", "#26A79B");
  });
  $('#close_paid').click(function() {
    $("#paid_ticket_div").css("display", "none");
  });




  var $navBar = $('.custom_nav.landing');
  var $navBar2 = $('.scroller')
    //
    //// find original navigation bar position
    //var navPos = $navBar.offset().top;
    //var footerPos = $('.page-footer').offset().top;
    //var sidePos = $('.hello').offset().top;
    //console.log('sidebar: ',sidePos)
    //console.log('footer: ',footerPos)
    // on scroll
  $(window).scroll(function() {

    //// get scroll position from top of the page
    var scrollPos = $(this).scrollTop();

    if (scrollPos >= 80) {
      $navBar.addClass('fixer');
      $navBar2.addClass('scroll-fix')

      $('.before-scroll').show();
      $('.alert-scroll-under').hide();
    } else {
      $navBar.removeClass('fixer');
      $('.before-scroll').hide();
      $('.alert-scroll-under').show();
      $navBar2.removeClass('scroll-fix')
    }

  });

  $('.file-uploader').click(function() {
    /* Act on the event */
    $('#event_photo_upload').trigger('click')
  });

  $('#event_photo_upload').change(function(event) {
    /* Act on the event */
    var reader = new FileReader()
    reader.onload = function (e) {
              $('#index-banner').css('background', "url("+e.target.result+")");
    }
    uploaded_file = $(this)[0].files[0]
    reader.readAsDataURL(uploaded_file);


    $('.events_pic_name').html(uploaded_file.name)
    //
    // //perform async post to server for the
    // var formdata = new FormData(uploaded_file);
    // // formdata.append('event_picture', uploaded_file, uploaded_file.name);
    // console.log(formdata);
    // $.ajax({
    //     url: '/events/new',
    //     type: 'POST',
    //     data: formdata,
    //     processData: false,
    //
    //   })
    //   .done(function() {
    //     console.log("success");
    //   })
    //   .fail(function() {
    //     console.log("error");
    //   })
    //   .always(function() {
    //     console.log("complete");
    //   });

  });

  //analytics
  (function(i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function() {
      (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o),
      m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
  })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

  ga('create', 'UA-65653167-1', 'auto');
  ga('send', 'pageview');


  var event_date = $('.our_parallax').data('countdown')
  if(event_date){
    countdown(convertDate(event_date));
  }

  // script for binding event details to preview page
  $(".preview").click(function(){

    var start_date = $("#event_start_date").val()
    var end_date = $("#event_end_date").val()
    if(start_date){
      countdown(convertDate(start_date));
    }

    var map_val = $("#event_map_url").val();
    if(map_val){
      var map = map_val + "&output=embed"
    }
    else {
      var map = 'https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb' + "&output=embed"
    }

    var description = ($("#event_description").val().length>200) ? $("#event_description").val().substr(0,200)+"..." : $("#event_description").val();
     $(".preview-tab").removeClass("disabled");
     $('ul.tabs').tabs('select_tab', 'test3');
     $(".preview-tab").addClass("disabled");
     $(".our-event-title").html($("#event_title").val());
     $(".our_event_description").html(description);
     $(".our-event-date").html(start_date+ " to "+ end_date);
     $(".our-event-map-url").attr({'src': map})
  })


});


/* Every time the window is scrolled ... */
$(window).scroll(function() {

  /* Check the location of each desired element */
  $('.hideme').each(function(i) {

    var bottom_of_object = $(this).offset().top + $(this).outerHeight();
    var bottom_of_window = $(window).scrollTop() + $(window).height();

    /* If the object is completely visible in the window, fade it in */
    if (bottom_of_window > bottom_of_object) {

      $(this).animate({
        'opacity': '1'
      }, 300);
    }
  });

});

$(document).ready(function() {
  var timesClicked = 0;
  $('#FEATURED').bind('click', function(event) {
    $('#examples-transition2').load('/welcome/featured #content', function() {
      //$(document).animate({'top': 5500}, 300);
      $(this).scroll(500);
      $(this).scrollTop(300);
      console.log('alex')
      timesClicked++;
      $('#examples-transition2').hide();
      $(this).fadeIn(1000);
      if (timesClicked >= 1) {
        $(this).unbind(event);
      }
    });
  });

  $('#POPULAR').bind('click', function(event) {
    $('#examples-transition3').load('/welcome/popular #content', function() {
      timesClicked++;
      $('#examples-transition3').hide();
      $(this).fadeIn(5000);
      if (timesClicked >= 1) {
        $(this).unbind(event);
      }
    });
  });
})


$(document).ready(function() {
  $(window).scroll(function() {
    var height = $('#content').height();
    var scroll = $(this).scrollTop();
    var win = $(window).height();
    var nav = $('.nav-wrapper').height();
    var height2 = height + 6 + nav - win

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
  });


});

function convertDate(startdate) {
  date = new Date();
  dateStr = startdate.toString();
  date2 = new Date(dateStr.replace(/-/g, '/'));
  diff = Math.floor((date2 - date) / (60 * 1000));

  return diff;
}


function countdown(val) {
  minutes = val
  if (minutes > 1) {
    var seconds = 60;
    var mins = minutes

    function tick() {
      var counter = document.getElementById("counter");
      $('#counter').css({
        'font-size': '3rem',
        'padding': '0 10px',
        'color': '#fff',
        'z-index': '100',
        'background-color': 'rgba(0,0,0,0.2)'
      })

      var current_minutes = mins - 1
      var days = Math.floor(current_minutes / (24 * 60));
      var hour_min = current_minutes % (24 * 60);
      var hour = Math.floor(hour_min / 60);
      mins2 = hour_min % 60;
      seconds--;
      counter.innerHTML = ((days > 0) ? days.toString() + "d :" : "") + (hour < 10 ? "0" : "") + hour.toString() + "h :" + mins2.toString() + "m :" + (seconds < 10 ? "0" : "") + String(seconds) + "s";
      if (seconds > 0) {
        setTimeout(tick, 1000);
      } else {
        if (mins > 1) {
          countdown(mins - 1);
        }
      }
    }
    tick();
  } else {
    counter.innerHTML = "This event has ended";
  }
}
