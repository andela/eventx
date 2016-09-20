function convertDate(startDate, startTime) {
  var date = new Date();
  var date2 = new Date(startDate);
  var apm = startTime.toString().split(":")[1].match(/^(\d+)([A|P]M)$/)[2];
  if (apm === "AM"){
    date2.setHours(startTime.split(":")[0]);
  } else {
    date2.setHours(+startTime.split(":")[0] + 12);
  }
  date2.setMinutes(startTime.split(":")[1].match(/^(\d+)[A|P]M$/)[1]);
  var diff = Math.floor((date2 - date) / (60 * 1000));
  return diff;
}

function countdown(val, end_date, end_time) {
  var endDate = new Date(end_date);
  var apm = end_time.toString().split(":")[1].match(/^(\d+)([A|P]M)$/)[2];
  if (apm === "AM"){
    endDate.setHours(end_time.split(":")[0]);
  } else {
    endDate.setHours(+end_time.split(":")[0] + 12);
  }
  endDate.setMinutes(end_time.split(":")[1].match(/^(\d+)[A|P]M$/)[1]);

  var minutes = val;

  $('#counter').css({
    'font-size': '3rem',
    'padding': '0 10px',
    'color': '#fff',
    'z-index': '100',
    'background-color': 'rgba(0,0,0,0.2)'
  });

  if (minutes > 0) {
    function tick() {
      var seconds = 60;
      var mins = minutes;
      var counter = document.getElementById('counter');
      var current_minutes = mins - 1;
      var days = Math.floor(current_minutes / (24 * 60));
      var hour_min = current_minutes % (24 * 60);
      var hour = Math.floor(hour_min / 60);
      var mins2 = hour_min % 60;
      seconds--;
      counter.innerHTML = (days > 0 ? days.toString() + 'd :' : '') + (hour < 10 ? '0' : '') + hour.toString() + 'h :' + mins2.toString() + 'm :' + (seconds < 10 ? '0' : '') + String(seconds) + 's';
      if (seconds > 0) {
        setTimeout(tick, 1000);
      } else {
        if (mins > 1) {
          countdown(mins - 1);
        }
      }
    }
    tick();
  } else if ((new Date()) > endDate) {
    counter.innerHTML = 'This event has ended';
  } else {
    counter.innerHTML = 'This event has started';
  }

}