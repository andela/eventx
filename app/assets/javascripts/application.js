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
    $(".more-info").click(function(){
        //preventDefault();
         $('ul.tabs').tabs('select_tab', 'test2');
    })
    $(".preview").click(function(){
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
      }
    );

    if(window.location.pathname != '/'){
      $('.melomelo').removeClass('before-scroll').css({'padding-top': '9px'});
      console.log('yes')
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
    setInterval(function () {
      $('.alert-scroll-under').animate({opacity: 0.1// , height: '5%', width: '5%'
    }, 500);
      $('.alert-scroll-under').animate({opacity: 1//, height: '2%', width: '2%'
    }, 500);
    }, 5);

    // This is used to handle the create ticket session
    // of the first page of the create event page
    $('#free_ticket_btn').click(function(){
        $("#free_ticket_div").css("display", "block");
        // Changes the create icon to teal
        $("#ticket_icon").css("color", "#26A79B");
    });
    $('#close_free').click(function(){
        $("#free_ticket_div").css("display", "none");
    });

    $('#paid_ticket_btn').click(function(){
        $("#paid_ticket_div").css("display", "block");
        // Changes the create icon to teal
        $("#ticket_icon").css("color", "#26A79B");
    });
    $('#close_paid').click(function(){
        $("#paid_ticket_div").css("display", "none");
    });

    /* Every time the window is scrolled ... */
    $(window).scroll( function(){

        /* Check the location of each desired element */
        $('.hideme').each( function(i){

            var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* If the object is completely visible in the window, fade it in */
            if( bottom_of_window > bottom_of_object ){

                $(this).animate({'opacity':'1'},300);

            }

        });

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

        if(scrollPos>=80){
            $navBar.addClass('fixer');
             $navBar2.addClass('scroll-fix')

            $('.before-scroll').show();
            $('.alert-scroll-under').hide();
        }else{
            $navBar.removeClass('fixer');
            $('.before-scroll').hide();
            $('.alert-scroll-under').show();
            $navBar2.removeClass('scroll-fix')
        }
        //console.log(scrollPos)

        //if((footerPos - scrollPos) > 550){
        //    $navBar2.removeClass('scroller3')
        //    $navBar2.addClass('scroller')
        //}else{
        //    $navBar2.removeClass('scroller')
        //    $navBar2.addClass('scroller3')
        //}

    });

    $('.file-uploader').click(function() {
      /* Act on the event */
      $('#event_photo_upload').trigger('click')
    });

    $('#event_photo_upload').change(function(event) {
      /* Act on the event */
        uploaded_file = $(this)[0].files[0]
        $('.events_pic_name').html(uploaded_file.name)

        //perform async post to server for the
        var formdata = new FormData(uploaded_file);
        // formdata.append('event_picture', uploaded_file, uploaded_file.name);
        console.log(formdata);
        $.ajax({
          url: '/events/new',
          type: 'POST',
          data: formdata,
          processData: false,
          // dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
          // data: {param1: 'value1'}
        })
        .done(function() {
          console.log("success");
        })
        .fail(function() {
          console.log("error");
        })
        .always(function() {
          console.log("complete");
        });

    });

    //analytics
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-65653167-1', 'auto');
    ga('send', 'pageview');



});


$(document).ready(function(){
    $('#FEATURED').click(function(){
        $('#examples-transition2').load('/welcome/featured #content');
    });

    $('#POPULAR').click(function(){
        $('#examples-transition3').load('/welcome/popular #content');
    });
})


