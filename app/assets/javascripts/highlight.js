var highlight_count = 0;

function removeHighlight(ele) {
  var deleteHighlight = confirm("Are you sure?");
  if (deleteHighlight){
    ele.closest('.nested_fields').remove();
  }
}


function objEmpty(obj){
  var res = [];
  for(prop in obj){
    res.push(obj[prop]);
  }
  res = res.join('');

  if(res.length <=0 ) {
    return true;
  }
    return false;
}

function clearFields (){
  var hfield = $("#highlight_field_new").children();
  var tag = '.highlight_';

  hfield.find(tag+'title').val("");
  hfield.find(tag+'description').val("");
  hfield.find(tag+'start_time').val("");
  hfield.find(tag+'end_time').val("");
  hfield.find(tag+'photo_upload').val("");
  hfield.find(tag+'caption').val("");
}

function appendHighlight (h) {
    var hfield = $("#highlight_field_new").children();
    var tag = '.highlight_';
    var data = {};

    data.title = hfield.find(tag+'title').val();
    data.description = hfield.find(tag+'description').val();
    data.start_time = hfield.find(tag+'start_time').val();
    data.end_time = hfield.find(tag+'end_time').val();
    data.img = localStorage.getItem('img');
    // hfield.find(tag+'photo_upload').val();
    data.caption = hfield.find(tag+'caption').val();

    if(objEmpty(data)) {
      return false;
    }

return [
        '<div class="collapsible-header tooltipped" data-position="bottom" data-delay="50" data-tooltip="Click to Expand">',
        data.title,
        '<span class="right">',
        data.start_time,
         ' - ',
        data.end_time,
        '<span class="right remove-highlight" onclick="removeHighlight($(this))"><i class="material-icons">delete</i></span>',
        '</span></div>',
        '<div class="collapsible-body"> <div class="row">',
        '<div class="col l6"><div>Image Caption</div>',
        '<div class="card-panel">',
        '<img id="img" class="materialboxed" width="100%" data-caption="Image Caption"',
        'src='+ data.img +'/>',
        '</div></div><div class="col l6">',
        '<p>' + data.description + '</p>',
        '</div></div></div>',
        h
     ].join('');

  }

function generateHighlight () {

  var hfield = $("#highlight_field_new").children();
  var tag = '.highlight_';
  var data = {};
  data.title = hfield.find(tag+'title').val();
  data.description = hfield.find(tag+'description').val();
  data.start_time = hfield.find(tag+'start_time').val();
  data.end_time = hfield.find(tag+'end_time').val();
  data.image = hfield.find(tag+'photo_upload').val();
  data.image_title = hfield.find(tag+'caption').val();

  if(data.title == undefined || data.title == "") {
    return false;
  }


  return `<div class='ha'><input type='hidden' name = 'event[highlights_attributes][${++highlight_count}][title]' value='${data.title}'>
  <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][description]' value='${data.description}'>
  <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][start_time]' value='${data.start_time}'>
  <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][end_time]' value='${data.end_time}'>
  <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image]' value='${data.image}'>
  <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image_title]' value='${data.image_title}'></div>`
};

$(document).ready(function(){

  $('#add_highlight').on('click', function(){
    $(".highlight_fields").hide();
    //if(generateHighlight()){
      // $('#event_highlights').append(generateHighlight());
    //}


    $('.tooltipped').tooltip({delay: 50});

    if(appendHighlight()){
      $('<li />', {html: appendHighlight(generateHighlight())}).addClass('nested_fields').appendTo('ul#highlight_table')
      $('.collapsible').collapsible();
    }

    localStorage.removeItem('img');
    clearFields();
    $("#highlight_field_new").removeClass("hide").show();
  });

  $('#highlight_field_new .highlight_start_time').pickatime({
      twelvehour: true
    });
  $('#highlight_field_new .highlight_end_time').pickatime({
    twelvehour: true
  });

  $('#highlight_table').on('click', '.btn-x', function(){
    $(this).closest('tr').remove();
  });

  $(".show_highlight_field").click(function(){
    $(".highlight_fields").hide();
    var id = $(this).attr("id").replace("form_id", "");
    $("#highlight_field"+id).removeClass('hide').fadeIn("slow");
  });

});
