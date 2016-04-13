$(document).ready(function(){
  $(".lever").on("click", function(){
    var status = !$(this).prev(".enable_event").prop("checked");
    var value = $(this).prev(".enable_event").prop("value");
    if (status) {
      $.ajax("/events/" + value + "/enable");
    } else {
      $.ajax("/events/" + value + "/disable");
    }
  });
});
