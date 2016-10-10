$(document).ready( function () {

  $('.event-time-picker').pickatime({ twelvehour: true });
  $('.event-time-picker').pickatime({ twelvehour: true });

  $('.recur-lever').on('click', function (){
    var status = !$('.recur-event').prop('checked');
    if (status){
      $('.recurring_event_space').removeClass('display-none');
    } else {
      $('.recurring_event_space').addClass('display-none');
      $('.week-frequency').addClass('display-none');
      $('.day-frequency').addClass('display-none');
      $('#event_recurring_event_attributes_frequency').val('');
      $('#event_recurring_event_attributes_week').val('');
      $('#event_recurring_event_attributes_day').val('');
    }
  });

  $('#event_recurring_event_attributes_frequency').on('change', function (){
    if (this.value === 'Weekly'){
      $('.week-frequency').addClass('display-none');
      $('.day-frequency').removeClass('display-none');
      $('#event_recurring_event_attributes_day').val('');
      $('#event_recurring_event_attributes_week').val('');
    } else if (this.value === 'Monthly') {
      $('.week-frequency').removeClass('display-none');
      $('.day-frequency').removeClass('display-none');
      $('#event_recurring_event_attributes_day').val('');
      $('#event_recurring_event_attributes_week').val('');
    } else {
      $('.week-frequency').addClass('display-none');
      $('.day-frequency').addClass('display-none');
      $('#event_recurring_event_attributes_day').val('');
      $('#event_recurring_event_attributes_week').val('');
    }
  });

});