$(document).ready(function () {
  $('.lever').on('click', function () {
    var status = !$(this).prev('.enable_event').prop('checked'),
        value = $(this).prev('.enable_event').prop('value');
    if (status) {
      processEvent('Event has been enabled', value, '/enable');
    } else {
      processEvent('Event has been disabled', value, '/disable');
    }
  });
});

function processEvent(message, value, endpoint) {
  $.ajax('/events/' + value + endpoint);
  Materialize.toast(message, 3000);
}