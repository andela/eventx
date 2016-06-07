$(document).ready(function () {
  $('.refund-button').click(function (){
    var uniq_id = $(this).data('id');
    $('#uniq_id').val(uniq_id);
  });

  $('#reason-label').hide();
  $('input[type="radio"]').click(function (){
    if ($('#reason-other').is(':checked')) {
      $('#reason-label').show();
    }else {
      $('#reason-label').hide();
    }
  });

  $('#submit-refund').click(function (){
    var reason = "Event was Cancelled"
    var uniq_id = $('#uniq_id').val();
    if ($("#reason-custom").val() !== ""){
      reason = $("#reason-custom").val();
    }
    $.ajax({
      url: '/refund/' + uniq_id,
      type: 'POST',
      data: { reason: reason }
    })
    .done(function(){
      Materialize.toast('Your request for refund has been submitted', 3000);
      var ele = $('*[data-id="' + uniq_id + '"]');
      ele.html('Processing Request');
      ele.attr('class','btn disabled print-box-size');
      ele.attr('href','#');
    })
    .fail(function(){
      Materialize.toast('Sorry, request for refund was not submitted', 3000);
    });
  });
});
