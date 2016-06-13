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
});
