$(function () {
  $('.event_ticket_input').change(function () {
    var tickets_quantity = parseInt($(this).val());
    var ticket_id = $(this).attr('id').match(/\d+/)[0];
    var ticket_type = '#ticket_type_' + ticket_id;
    if (tickets_quantity > 0) {
      $(ticket_type).attr({ 'checked': true });
    } else {
      $(ticket_type).attr({ 'checked': false });
    }
  });
  $('a.add_another_ticket').click(function (e) {
    e.preventDefault();
  });
});