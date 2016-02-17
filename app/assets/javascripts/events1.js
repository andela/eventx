$(function(){
  $(".event_ticket_input").change(function() {
    tickets_quantity = parseInt($(this).val());
    ticket_id = $(this).attr("id").match(/\d+/)[0];
    ticket_type= "#ticket_type_" + ticket_id;
    if(tickets_quantity > 0){
      $(ticket_type).attr({"checked": true});
    } else{
      $(ticket_type).attr({"checked": false});
    }
  });
});

function remove_fields(link){
  $(link).prevAll("input[type=hidden]").first().val("1");
  $(link).closest("li").hide();
}

function add_fields(link, association, content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var field = content.replace(regexp, new_id);
  $("div.event_ticket_field").append(field);
}

  $(function(){
    $("a.add_another_ticket").click(function(e){ e.preventDefault();});
  });

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
