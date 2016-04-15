$(document).ready(function () {
  $('#user_event_search_form input').keyup(function () {
    $.get($('#user_event_search_form').attr('action'), $('#user_event_search_form').serialize(), null, 'script');
    return false;
  });
  $('#preview-event-div a').each(function () {
    $(this).removeAttr('data-target');
    $(this).attr({ 'href': '#' });
  });
  $('#preview-event-div a').click(function (e) {
    e.preventDefault();
  });
});
