$(document).ready(function () {
  $('.file-uploader').click(function () {
    /* Act on the event */
    $('#event_photo_upload').trigger('click');
  });
  $('#event_photo_upload').change(function () {
    /* Act on the event */
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#index-banner').css('background', 'url(' + e.target.result + ')');
    };
    var uploaded_file = $(this)[0].files[0];
    reader.readAsDataURL(uploaded_file);
    $('.events_pic_name').html(uploaded_file.name);
  });
});
