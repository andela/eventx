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
//
//// find original navigation bar position
    var navPos = $navBar.offset().top;

// on scroll
    $(window).scroll(function() {

        //// get scroll position from top of the page
        var scrollPos = $(this).scrollTop();
        if(scrollPos>=80){
            $navBar.addClass('fixer');
            // $navBar.addClass('after-scroll');
            $('.before-scroll').show();
            $('.alert-scroll-under').hide();
        }else{
            $navBar.removeClass('fixer');
            $('.before-scroll').hide();
            $('.alert-scroll-under').show();
        }
        //// check if scroll position is >= the nav position
        //if (scrollPos >= navPos) {
        //$navBar.addClass('nav-fixed');

        //$navBar.addClass('right');
        //} else {
        //    $navBar.removeClass('fixed');
        //}

    });
});
