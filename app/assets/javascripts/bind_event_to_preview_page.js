$(document).ready(function () {
  var event_date = $('.parallax-container').data('countdown'),
      end_date = $('.end_date').data('countdown'),
      start_time = $('.start_time').data('countdown'),
      end_time = $('.end_time').data('countdown'),
      prev_color = '',
      color = '',
      map;

  if (event_date) { countdown(convertDate(event_date, start_time), end_date, end_time); };

  $('.preview').click(function () {
    var map_val = $('#event_map_url').val(),
        start_date = $('#event_start_date').val(),
        end_date = $('#event_end_date').val(),
        start_time = $('#event_start_time').val(),
        end_time = $('#event_end_time').val(),
        frequency = $('#event_recurring_event_attributes_frequency').val(),
        week = $('#event_recurring_event_attributes_week').val(),
        day = $('#event_recurring_event_attributes_day').val();

    if (frequency === "Daily"){
      rec_text = "Every Day from "
    } else if (frequency === "Weekly"){
      rec_text = "Every " + day + " from "
    } else if (frequency === "Monthly"){
      rec_text = "Every " + week + " " + day + " of the Month, from "
    } else {
      rec_text = ""
    }

    if (start_date) { countdown(convertDate(start_date, start_time), end_date, end_time); };

    if (map_val) {
      map = map_val + '&output=embed';
    } else {
      map = 'https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb' + '&output=embed';
    }

    prev_color = color;
    color = $('input[name=\'event[event_template_id]\']:checked').attr('id') + ' darken-4';

    var description_selector = $('#event_description').val() === '' ? 'Your Event description goes here<br/><br/><br/><br/>' : $('#event_description').val();
    var description = description_selector.length > 200 ? description_selector.substr(0, 200) + '...' : description_selector;
    var title = $('#event_title').val() === '' ? 'Event title goes here' : $('#event_title').val();
    $('.our-event-title').html(title);
    $('.our_event_description').html(description);
    if (rec_text !== ""){
      $('.our-event-date').html(start_date + ' - ' + end_date);
      $('.our-event-time').html(rec_text + start_time + ' to ' + end_time);
    } else {
      $('.our-event-date').html(start_date + ", " + start_time + ' - ' + end_date + ", " + end_time);
      $('.our-event-time').html("");
    }
    $('.landing2').removeClass(prev_color);
    $('.landing2').addClass(color);
    $('.our-event-map-url').attr({ 'src': map });
    // hightlights data
    var h_title = $('#highlight_title').val();
    $('#event_page_highlight').html($('ul#highlight_table').html());
    $('.collapsible').collapsible();
  });
});  /* Every time the window is scrolled ... */
