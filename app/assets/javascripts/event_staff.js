$(document).ready(function () {
  $('.add_staff_field').autocomplete({
    delay: 500,
    minLength: 4,
    source: '/lookup_staffs',
    select: function (event, ui) {
      var staffId = ui.item.data;
      if ($('.event_staffs').length > 0) {
        $.get('/user_info/' + staffId, function (data) {
          $('.event_staffs').append(data);
          $('.add_staff_field').val('');
        });
      } else {
        $('#new_staff').val(staffId);
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
  $('.event_staffs').on('click', '.remove_staff', function () {
    $(this).parents('.chip').hide('slow', function () {
      $(this).remove();
    });
  });
});
