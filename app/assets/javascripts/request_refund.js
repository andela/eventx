$(document).ready(function () {
  $('.refund-button').click(function () {
    var uniq_id = $(this).data('id');
    $('#uniq_id').val(uniq_id);
  });
  $('#reason-label').hide();
  $('input[type="radio"]').click(function () {
    if ($('#reason-other').is(':checked')) {
      $('#reason-label').show();
    } else {
      $('#reason-label').hide();
    }
  });
  $('#submit-refund').click(function () {
    var reason = 'Event was Cancelled',
        uniq_id = $('#uniq_id').val(),
        custom_reason = $('#reason-custom').val();
    if (custom_reason !== '') {
      reason = $('#reason-custom').val();
    }
    $.ajax({
      url: '/refund/' + uniq_id,
      type: 'POST',
      data: { reason: reason }
    }).done(function () {
      Materialize.toast('Your request for refund has been submitted', 3000);
      var refund_button = $('*[data-id="' + uniq_id + '"]');
      refund_button.html('Processing Request');
      refund_button.attr('class', 'btn disabled print-box-size');
      refund_button.attr('href', '#');
    }).fail(function () {
      Materialize.toast('Sorry, request for refund was not submitted', 3000);
    });
  });
});
