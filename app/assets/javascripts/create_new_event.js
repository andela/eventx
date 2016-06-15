var obj = {1: "#create", 2: "#booking", 3: "#template"};
var count = 1;
$(document).ready(function(){
  var default_hidden = ["#booking", "#template"],
      len = default_hidden.length;
  for(var i = 0; i<len; i++) {
    $(default_hidden[i]).hide();
  }

  $("#btn_booking").click(function(){
    $(obj[count]).hide();
    count += 1;
    $(obj[count]).show();
  });

  $("#btn_previous").click(function(){
    $(obj[count]).hide();
    count -= 1
    $(obj[count]).show();
  });

  //  $("#btn_booking").click(function(){
  //   $("#booking").show();
  //   $("#template").hide();
  // });
  //   $("#btn_booking").click(function(){
  //   $("#booking").hide();
  //   $("#template").show();
  //});
});