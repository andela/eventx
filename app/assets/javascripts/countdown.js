function convertDate(startdate) {
  var date = new Date();
  var dateStr = startdate.toString();
  var date2 = new Date(dateStr.replace(/-/g, '/'));
  var diff = Math.floor((date2 - date) / (60 * 1000));
  return diff;
}
function countdown(val) {
  var minutes = val;
  $('#counter').css({
    'font-size': '3rem',
    'padding': '0 10px',
    'color': '#fff',
    'z-index': '100',
    'background-color': 'rgba(0,0,0,0.2)'
  });
  if (minutes > 1) {
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
  } else {
    counter.innerHTML = 'This event has ended';
  }
}