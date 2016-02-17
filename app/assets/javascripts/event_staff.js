$(document).ready(function(){

    var notify = function(message){
        Materialize.toast(message, 3000, "rounded");
    };

    var validateForm = function(){
        var empty_fields = [];
        var requiredFields = $("#event_title, #event_location, #event_category_id, #event_description");
        for(var i=0, len=requiredFields.length; i<len; i++){
            var current_field = requiredFields[i];
            if(current_field.value == ""){
                current_field.name = current_field.name.replace("[", " ");
                current_field.name = current_field.name.replace("]", " ");
                current_field.name = current_field.name.replace("_id", "");
                empty_fields.push(current_field.name);
            }
        }
        empty_fields.forEach(function(value){
           notify(value + " is required!")
        });
    };

    $('#save_event').on("click", function(){
        validateForm();
    });

    var isExistingOnPage = function (userId) {
    var parent = $("#event_staffs").children(),
        isOnPage = false;

    for (var i = 0, len = parent.length; i < len; i += 1) {
      if(parent[i].dataset.id === userId) {
      isOnPage = true;
      break;
      }
    }
    return isOnPage;
  };

  var generateHtml = function(data){
    return [ "<div class='chip' data-id =",  data.user_id,  ">",
            "<img src=", data.profile_url,  "alt='Contact Person'>",  data.first_name,  " ( ",  data.user_role,  " )&emsp;",
             "<a href='#' data-remote='true'><span class='remove_staff'>x</span></a>",
             "<input type='hidden' class='uid'name = 'event[event_staffs_attributes][][user_id]' value =", data.user_id, "/>",
             "<input type='hidden' name = 'event[event_staffs_attributes][][role]' value =", data.role, "/></div>" ].join('\n');
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

  $(".add_staff_field").autocomplete({
      delay:500,
      minLength: 1,
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
