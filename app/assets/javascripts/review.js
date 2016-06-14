// $(document).ready(function(){
//     // $("#replyButton").click(function(){
//     //     $("#replyForm").hide();
//     // });
//     $("#replyButton").click(function(){
//         $("replyForm").show();
//     });
// });
$(document).ready(function() {
  //Hide Search field
  $( "#replyButton" ).click(function() {
    $("#replyForm" ).toggle("slide", { direction: "down" }, 500);
  });

  $('#addReview').click(function (){
      var body = $("#reviewBody").val()
      var event_id = $('#reviewEventId').val();
      $.ajax({
        url: '/events/' + event_id + '/reviews',
        type: 'POST',
        data: { review: { body: body, event_id: event_id } }
      })
      .done(function(data){
        console.log(data);
        Materialize.toast('Your request for refund has been submitted', 3000);
        var clonedDiv = $('#review').clone();
        console.log(clonedDiv);
        clonedDiv.find("#reviewBodyContent").html(data.body)
        clonedDiv.find(".review-author-name").html("Ruby Hyperloop")
        clonedDiv.attr("id", "newId");
        $('#review').after(clonedDiv);





        // var ele = $('*[data-id="' + uniq_id + '"]');
        // ele.html('Processing Request');
        // ele.attr('class','btn disabled print-box-size');
        // ele.attr('href','#');
      })
      .fail(function(){
        Materialize.toast('Sorry, request for refund was not submitted', 3000);
      });

      event.preventDefault()
    });
});
