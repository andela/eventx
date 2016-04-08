function highLight() {
  var highlight_count = 0;

  function removeHighlight(ele) {
    var deleteHighlight = confirm("Are you sure?");
    if (deleteHighlight){
      ele.closest('li').remove();
    }
  }


  function objEmpty(){
    var data = hightlightData();
    var res = [];
    for(prop in data){
      res.push(data[prop]);
    }
    res = res.join('');
    return res == '';
  };

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

  function hightlightData() {
    var hfield = $("#highlight_field_new").children();
    var tag = '.highlight_';
    var data = {};

    data.title = hfield.find(tag+'title').val();
    data.description = hfield.find(tag+'description').val();
    data.start_time = hfield.find(tag+'start_time').val();
    data.end_time = hfield.find(tag+'end_time').val();
    data.image = localStorage.getItem('highlight_photo_upload');
    // hfield.find(tag+'photo_upload').val();
    data.caption = hfield.find(tag+'caption').val();
    return data;
  };

  function generateHighlightHtml() {
      var data = hightlightData();
      return accordionItemHtml(data) + hiddenFieldHtml(data)
    }


  function hiddenFieldHtml(data) {
    return `<div class='ha'><input type='hidden' name = 'event[highlights_attributes][${++highlight_count}][title]' value='${data.title}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][description]' value='${data.description}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][start_time]' value='${data.start_time}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][end_time]' value='${data.end_time}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image]' value='${data.image}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image_title]' value='${data.caption}'></div>`
  };

  function accordionItemHtml(data) {
    return [
            '<div class="collapsible-header tooltipped" data-position="bottom" data-delay="50" data-tooltip="Click to Expand">',
            data.title,
            '<span class="right">',
            data.start_time,
             ' - ',
            data.end_time,
            '<span class="right remove-highlight" onclick="highLight().remove($(this))"><i class="material-icons">delete</i></span>',
            '</span></div>',
            '<div class="collapsible-body"> <div class="row">',
            '<div class="col l6 m6">',
            '<div class="card-panel">',
            '<img id="img" class="materialboxed" width="100%" data-caption="',
            data.caption + '"',
            'src="'+ data.image +'"/>',
            '</div></div><div class="col l6">',
            '<p>' + data.description + '</p>',
            '</div></div></div>'
         ].join('');
  };
  return {
    remove: removeHighlight,
    clearFields: clearFields,
    generateHtml: generateHighlightHtml,
    empty: objEmpty
  }
};
