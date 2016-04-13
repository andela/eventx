$(document).ready(function(){
  var highlight_count = 0;
  $('#add_highlight').on('click', function(){
    var highlight = highLight();
    $(".highlight_fields").hide();
    $('.tooltipped').tooltip({delay: 50});
    if(!highlight.empty()){
      $('<li />', {html: highlight.generateHtml(highlight_count)}).appendTo('ul#highlight_table')
      $('.collapsible').collapsible();
      $('.materialboxed').materialbox();
      highlight_count++;
    };

    localStorage.removeItem('highlight_photo_upload');
    highlight.clearFields();
    $("#highlight_field_new").toggleClass("hide").show();
  });

  $('#highlight_field_new .highlight_start_time').pickatime({
      twelvehour: true
  });

  $('#highlight_field_new .highlight_end_time').pickatime({
    twelvehour: true
  });

  $('.remove-highlight').on('click', function(){
    highLight().remove($(this))
  });

  $('.highlight_photo_upload').on('change', function () {
    var reader = new FileReader();
    reader.onloadend = function (e) {
      localStorage.setItem('highlight_photo_upload', reader.result);
    };

    var uploaded_file = $(this)[0].files[0];
    reader.readAsDataURL(uploaded_file);
  });
});
