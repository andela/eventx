$(document).ready(function () {
  $('.lever').on('click', function () {
    var status = !$(this).prev('.enable_event').prop('checked');
    var value = $(this).prev('.enable_event').prop('value');
    if (status) {
      $.ajax('/events/' + value + '/enable');
      Materialize.toast('Event has been enabled', 3000);
    } else {
      $.ajax('/events/' + value + '/disable');
      Materialize.toast('Event has been disabled', 3000);
    }
  });
});
