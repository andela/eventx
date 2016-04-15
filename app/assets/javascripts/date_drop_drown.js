$(document).ready(function () {
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
});
