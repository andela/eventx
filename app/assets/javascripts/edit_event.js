$(document).ready(function () {
  $('#edit-event').click(function () {
    var event_id = $(this).data('eventid');
    // console.log(event_id)
    $('#content').load('/events/' + event_id + '/edit');
  });
});
