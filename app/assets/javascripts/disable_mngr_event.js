$(document).ready(function () {
  $('.mngr-lever').on('click', function () {
    var status = !$(this).prev('.enable_event').prop('checked'),
        value = $(this).prev('.enable_event').prop('value');
    if (status) {
      processMngrEvent('Event has been enabled', value, '/enable');
    } else {
      processMngrEvent('Event has been disabled', value, '/disable');
    }
  });
});

function processMngrEvent(message, value, endpoint) {
  $.ajax('/events/' + value + endpoint);
  Materialize.toast(message, 3000);
}