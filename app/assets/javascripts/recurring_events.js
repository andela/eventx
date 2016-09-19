$(document).ready( function () {

  $('.event-time-picker').pickatime({ twelvehour: true });
  $('.event-time-picker').pickatime({ twelvehour: true });

  $('.recur-lever').on('click', function (){
    var status = !$('.recur-event').prop('checked');
    if (status){
      $('.recurring-event').removeClass('display-none');
    } else {
      $('.recurring-event').addClass('display-none');
    }
  });

  $('#frequency').on('change', function (){
    if (this.value === "Weekly"){
      $('.week-frequency').removeClass('display-none');
    } else {
      $('.week-frequency').addClass('display-none');
    }
  });

});