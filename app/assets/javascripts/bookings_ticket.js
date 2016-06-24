$(document).ready(function(){    
  $("#btn_ticket_form").click(function(){

    var ticket_ids = [];  
    var user_data = "";
    $("input[name='ticket_ids']:checked").each(function(){
        ticket_ids.push($(this).val()); 
    });

    if(ticket_ids.length == 0){
      notify('Please select at least one ticket to transfer')
      return; 
    }

    var staffId = $('#staff_id').val(), email = $('#staff_field_id'), staffRole;
    if (!validateEmailField(email, staffId)) {
      return;
    } else {
      notify('User exist');
      $.get('/user_info/' + staffId + '?role=' + staffRole, function (data) {
        $('#user').append(generateHtml(data));
        var transaction = {
          booking_id: $("#booking_id").val(),
          recipient: data.user_id,
          ticket_ids: ticket_ids,
        };

        $.post('/ticket_transactions', transaction, function(data, status){
          if(data.status == 200){ window.location = data.location }
        });
      });  
    }
  });
});
        

function validateEmailField(email, staffId) {
  if (email.val().length < 1 && staffId.length < 1) {
    notify('Email field can\'t be blank');
    return false;
  } else if (email.val().length > 0 && staffId.length < 1) {
    notify('This user does not exist');
    return false;
  } else {
    return true; 
  }
};

function notify(msg){
  Materialize.toast(msg, 3000)
}

function generateHtml(data) {
    return [
      '<div class=\'chip\'  data-id =',
      data.user_id,
      '>',
      '<img src=',
      data.profile_url,
      'alt=\'Contact Person\'>',
      data.first_name,
      ' ( ',
      data.user_role,
      ' )&emsp;',
      '<a href=\'#\' data-remote=\'true\'><span class=\'remove_staff\'>x</span></a>',
      '<input type=\'hidden\' class=\'uid\'name = \'event[event_staffs_attributes][][user_id]\' value =',
      data.user_id,
      '/>',
      '<input type=\'hidden\' name = \'event[event_staffs_attributes][][role]\' value =',
      data.role,
      '/></div>'
    ].join('\n');
  };
