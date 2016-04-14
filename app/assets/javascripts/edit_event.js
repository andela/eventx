$(document).ready(function () {
  $('#edit-event').click(function () {
    var event_id = $(this).data('eventid');
    $('#content').load('/events/' + event_id + '/edit');
  });
});
