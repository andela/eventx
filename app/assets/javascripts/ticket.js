$(document).ready(function () {
  // This is used to handle the create ticket session
  // of the first page of the create event page
  $('#free_ticket_btn').click(function () {
    $('#free_ticket_div').css('display', 'block');
    // Changes the create icon to teal
    $('#ticket_icon').css('color', '#26A79B');
  });
  $('#close_free').click(function () {
    $('#free_ticket_div').css('display', 'none');
  });
  $('#paid_ticket_btn').click(function () {
    $('#paid_ticket_div').css('display', 'block');
    // Changes the create icon to teal
    $('#ticket_icon').css('color', '#26A79B');
  });
  $('#close_paid').click(function () {
    $('#paid_ticket_div').css('display', 'none');
  });
  //initialize select
});
