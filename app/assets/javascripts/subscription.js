$(document).ready(function(){
  $("#btn_subscribe").click(function (){
    $("#subscribe").closeModal();
    var event_id, data;
    event_id = $("input[name=sub_event_id]:checkbox:checked").val();
    data = { subscription: {
      event_id: event_id,
      manager_profile_id: $("input[name=sub_man_id]:checkbox:checked").val(),
      user_id: $("#subscription_user_id").val()
    }};

    $.ajax({
      url: "/events/" + event_id + "/subscriptions",
      type: "POST",
      data: data
    })

    .done(function(data){
      $("#subscribeBtn").hide();
      $("#unsubscribeBtn").attr("subscription", data.id);
      $("#unsubscribeBtn").show();
      Materialize.toast("You have been subscribed to this event", 3000);
    })

    .fail(function(){
      Materialize.toast("Unable to subscribe to this event", 3000);
    });

    event.preventDefault();
  });

  $("#unsubscribeBtn").click(function(){
    var data_confirm = confirm("Are You Sure");
    if(data_confirm){
      var event_id, subscription_id, data;
      event_id =  $("#unsubscribeBtn").attr("event");
      subscription_id = $("#unsubscribeBtn").attr("subscription");
      data = {
        event_id: event_id
      };

      $.ajax({
        url: "/events/" + event_id + "/subscriptions/" + subscription_id,
        type: "DELETE",
        data: data
      })

      .done(function(data){
        $("#subscribeBtn").show();
        $("#unsubscribeBtn").hide();
        Materialize.toast("You have unsubscribed from this event", 3000);
      })

      .fail(function(){
        Materialize.toast("Unable to unsubscribe from this event", 3000);
      });
    }
  });
});
