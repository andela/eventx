var obj = {1: "#create", 2: "#booking", 3: "#template"};

$(document).ready(function(){
  var default_hidden = ["#booking", "#template"],
      len = default_hidden.length;
  for(var i = 0; i<len; i++) {
    $(default_hidden[i]).hide();
  }

  $("#btn_booking").click(function(){
    $("#create").hide();
    $("#booking").show();
  });


   $("#btn_booking").click(function(){
    $("#booking").hide();
    $("#template").show();
  });
});