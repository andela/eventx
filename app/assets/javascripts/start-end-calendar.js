$(document).ready(function () {
  var event_start_date = $('#event_start_date').data('event-start-date');
  var event_end_date = $('#event_end_date').data('event-end-date');
  if (event_start_date && event_end_date) {
    event_start_date = new Date(event_start_date);
    event_end_date = new Date(event_end_date);
    $('#event_start_date').pickadate('picker').set('select', event_start_date);
    $('#event_end_date').pickadate('picker').set('select', event_end_date);
  }
});