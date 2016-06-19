$(document).ready(function () {
  alert("test")
  $('#subscriptionForm').submit(function (event) {
    alert("test")
    var event_id, manager_profile_id, user_id;
    event_id = $("input[name=subscription_event_id]:checkbox:checked").val()
    manager_profile_id = $("input[name=subscription_manager_profile_id]:checkbox:checked").val()
    user_id = $("#subscription_user_id").val();
    console.log(event_id);
    console.log(manager_profile_id);
    console.log(user_id);

    event.preventDefault()
  });
});
