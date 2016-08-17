$(document).ready(function () {
  $('.user-lever').on('click', function () {
    var status = !$(this).prev('.unattend_event').prop('checked'),
        eventId = $(this).prev('.unattend_event').prop('value'),
        userId = $(this).prev('.unattend_event').data('user');
    if (status) {
      processUserEvent('You are now attending this event', eventId, userId);
    } else {
      processUserEvent('You have unattended this event', eventId, userId);
    }
  });
});

function processUserEvent(message, event, user) {
  $.ajax({
    url: 'unattend',
    data: {"user_id": user, "event_id": event}
  }).done(function(){
    Materialize.toast(message, 3000);
  });
  return true;
}