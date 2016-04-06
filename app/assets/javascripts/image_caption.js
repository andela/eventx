$(document).ready(function () {
  $('#highlight_photo_upload').change(function () {
    var reader = new FileReader();
    reader.onload = function (e) {
      localStorage.setItem('highlight_photo_upload', e.target.result)
    };
  });

});
