var events_cards = {1: "#create", 2: "#booking", 3: "#template", 4: "#preview_template"},
    count = 1,
    hide_event_cards = ["#booking", "#template", "#preview_template"],
    card_length = hide_event_cards.length;

$(document).ready(function() {
  if (count == 1) { $("#btn_previous").hide(); }
  for(var i = 0; i<card_length; i++) { $(hide_event_cards[i]).hide(); }
  $("#saved_events").hide();

  $("#btn_booking").click(function(){
    $(events_cards[count]).hide();
    count += 1;
    setButtons (count);
    $("html, body").animate({ scrollTop: 0}, "slow");
    $(events_cards[count]).show();
  });

  $("#btn_previous").click(function(){
    $(events_cards[count]).hide();
    count -= 1;
    setButtons (count);
    $(events_cards[count]).show();
  });

  function setButtons(count){
    if (count == 4) {
      $("#btn_booking").hide();
      $("#saved_events").show();
    } else {
      $("#saved_events").hide();
      if (count == 1) { $("#btn_previous").hide(); }
      if (count > 1) { $("#btn_previous").show(); }
      if (count > 1) { $("#btn_booking").html("Next <i class='fa fa-hand-o-right'></i>").show(); }
      if (count == 3) { $("#btn_booking").html("Finish<i class='fa fa-hand-o-right'></i>"); }
    }
  }
});