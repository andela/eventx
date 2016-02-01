$(document).ready(function(){

  var isExistingOnPage = function (userId) {
    var parent = $("#event_staffs").children(),
        isOnPage = false;

    for (var i = 0; i < parent.length; i += 1) {
      if(parent[i].dataset.id === userId) {
      isOnPage = true;
      break;
      }
    }
    return isOnPage;
  };

  var generateHtml = function(data){
    return `<div class="chip" data-id= "` + data.user_id + `">
      <img src="`+ data.profile_url + `" alt="Contact Person">
      ` + data.first_name + ` (` + data.user_role+ `)&emsp;
      <a href="#" data-remote="true"><span class="remove_staff">x</span></a>
      <input type="hidden" class="uid"name = "event[event_staffs_attributes][][user_id]" value = "` + data.user_id + `" />
      <input type="hidden" name = "event[event_staffs_attributes][][role]" value = "` + data.role + `" />
    </div>`;
  };

  var validateEmailField = function (email, staffId) {
    if ( email.val().length < 1 && staffId.length < 1 ) {
      notify("Email field can't be blank");
      return true;
    } else if ( email.val().length > 0 && staffId.length < 1 ) {
      notify("This user does not exist");
      return true;
    }
  };

  var notify = function(message){
    Materialize.toast(message, 3000, "rounded");
  };

  $(".add_staff_field").autocomplete({
      delay:500,
      minLength: 4,
      source: "/lookup_staffs",
      select:function(event, ui){
        var staffId = ui.item.data;
        $("#staff_id").val(staffId);
      }
  });

    $(".event_staffs").on("click", ".remove_staff", function(){
      $(this).parents(".chip").hide("slow", function() { $(this).remove(); });
    });

    $("#add_staff").on("click", function(){
        var staffId = $("#staff_id").val(),
            email = $("#staff_field_id"),
            staffRole;

        if (validateEmailField(email, staffId)) {
          return;
        }

        staffRole = $("[name='role']").val();
        $.get("/user_info/" +staffId +"?role=" + staffRole, function(data){
          if (isExistingOnPage(data.user_id)){
            notify("This user has been added already");
          }else{
            $("#event_staffs").append(generateHtml(data));
            notify("Staff has been successfuly added");
            $("#staff_field_id").val("");
            $("#staff_id").val("");
          }
      });
    });
  });
