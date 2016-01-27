$(document).ready(function(){
  $(".add_staff_field").autocomplete({
    delay: 500,
    minLength: 4,
    source: "/lookup_staffs",
    select: function(event, ui){
      var staffId = ui.item.data;
      $.get("/user_info/" + staffId, function(data){
        $(".event_staffs").append(data);
        $(".add_staff_field").val("");
      });
    }
  });

  $(".event_staffs").on("click", ".remove_staff", function(){
    $(this).parents(".chip").hide("slow", function() { $(this).remove(); });
  });
});
