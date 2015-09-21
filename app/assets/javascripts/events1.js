$(function(){
  $('.event_ticket_input').keyup(function() {
    tickets_quantity = parseInt($(this).val());
    ticket_id = $(this).attr('id').match(/\d+/)[0];
    ticket_type= '#ticket_type_' + ticket_id;
    if(tickets_quantity > 0){
      $(ticket_type).attr({'checked': true});
    } else{
      $(ticket_type).attr({'checked': false});
    }
  });
});

function remove_fields(link){
  $(link).prevAll("input[type=hidden]").first().val("1");
  $(link).closest('li').hide();
  // decrement_price()
}

function add_fields(link, association, content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, 'g');
  field = content.replace(regexp, new_id);
  // field = content.replace(regexp, new_id);
  // console.log($('div.event_ticket_field'));
  $('div.event_ticket_field').append(field);
  // increment_price();
}

  $(function(){
    $('a.add_another_ticket').click(function(e){ e.preventDefault();});
  });
      // $(this).attr({'checked': false});
      // $
      // closest_checkbox =
    // closest_checkbox = $('#tickets_quantity_')
    // $(this).closest('')
      // $(this).parents().attr({'checked': true});
    /* Act on the event */
    // console.log('exent', tickets_quantity);
