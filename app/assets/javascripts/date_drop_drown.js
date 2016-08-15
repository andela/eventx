$(document).ready(function () {
  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrain_width: false,
    hover: true,
  });
  if (window.location.pathname != '/') {
    $('.our-custom-header').removeClass('before-scroll').css({ 'padding-top': '9px' });
  }
  $('.button-collapse').sideNav();
  $('select').material_select();
  $('.parallax').parallax();
  $('.modal-trigger').leanModal();
  // $('.menu-collapse').sideNav();
  $('ul.pagination li').click(function () {
    $('ul.pagination li').removeClass('active');
  });
  $('.datepicker').pickadate({
    selectMonths: true,
    // Creates a dropdown to control month
    selectYears: 15  // Creates a dropdown of 15 years to control year
  });
});
