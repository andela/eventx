function highLight() {
  function removeHighlight(ele) {
    var deleteHighlight = confirm("Are you sure?");
    if (deleteHighlight){
      ele.closest('li').remove();
    }
  }

  function editHighlight(ele) {

    $("#highlight_field_new").toggleClass("hide").show();
    var values = fetchValues(ele);
        populateFields(values);
    ele.closest('li').remove();
  }

  function fetchValues(ele) {
    var collapsibleHeader = ele.closest('.collapsible-header');
    var fields = ["day", "title", "description", "start_time", "end_time", "image", "image_title"];
    saveImage(collapsibleHeader);
    var collapsibleData = _.map(fields, function(name){
      return [ name, collapsibleHeader.siblings('.ha').find('[name*='+ name +']')[0].value ]
    });

    return collapsibleData;
  }

  function populateFields(collapsibleData){
    var collapsibleData = _.fromPairs(collapsibleData),
       hfield = $("#highlight_field_new").children(),
       tag = '.highlight_';

    _.forEach(collapsibleData, function(value, key){
      hfield.find(tag + key).val(value);
    })
  }

  function saveImage(ele){
    var image = ele.siblings('.collapsible-body').find('#img').attr('src');
    localStorage.setItem('highlight_photo_upload', image);
  }

  function fieldEmpty(){
    var data = hightlightData();
    delete data.image_title;
    delete data.image;
    var arr = _.toArray(data);
    return arr.some(function(value){
        return value === "" ;
    });
  }

  function clearFields (){
    var hfield = $("#highlight_field_new").children();
    var tag = '.highlight_';

    hfield.find(tag+'day').val("");
    hfield.find(tag+'title').val("");
    hfield.find(tag+'description').val("");
    hfield.find(tag+'start_time').val("");
    hfield.find(tag+'end_time').val("");
    hfield.find(tag+'photo_upload').val("");
    hfield.find(tag+'image_title').val("");
  }

  function hightlightData() {
    var hfield = $("#highlight_field_new").children();
    var tag = '.highlight_';
    var data = {};

    data.day = hfield.find(tag+'day').val();
    data.title = hfield.find(tag+'title').val();
    data.description = _.escape(hfield.find(tag+'description').val());
    data.start_time = hfield.find(tag+'start_time').val();
    data.end_time = hfield.find(tag+'end_time').val();
    data.image = localStorage.getItem('highlight_photo_upload');
    // hfield.find(tag+'photo_upload').val();
    data.image_title = hfield.find(tag+'image_title').val();
    return data;
  };

  function generateHighlightHtml(highlight_count) {
      var data = hightlightData();
      return accordionItemHtml(data) + hiddenFieldHtml(data, highlight_count)
    }


  function hiddenFieldHtml(data, highlight_count) {
    return `<div class='ha'><input type='hidden' name = 'event[highlights_attributes][${highlight_count}][title]' value="${data.title}">
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][day]' value='${data.day}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][description]' value="${data.description}">
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][start_time]' value='${data.start_time}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][end_time]' value='${data.end_time}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image]' value='${data.image}'>
    <input type='hidden' name = 'event[highlights_attributes][${highlight_count}][image_title]' value='${data.image_title}'></div>`
  };

  function accordionItemHtml(data) {
    return [
            '<div class="collapsible-header tooltipped" data-position="bottom" data-delay="50" data-tooltip="Click to Expand">',
            data.day + ' - ' + data.title,
            '<span class="right">',
            data.start_time,
             ' - ',
            data.end_time,
            '<span class="right edit-highlight" onclick="highLight().edit($(this))"><i class="material-icons">edit</i></span>',
            '<span class="right remove-highlight" onclick="highLight().remove($(this))"><i class="material-icons">delete</i></span>',
            '</span></div>',
            '<div class="collapsible-body"> <div class="row">',
            '<div class="col l6 m6">',
            '<div class="card-panel">',
            '<img id="img" class="materialboxed" width="100%" data-caption="',
            data.image_title + '"',
            'src="'+ data.image +'"/>',
            '</div></div><div class="col l6">',
            '<p>' + data.description + '</p>',
            '</div></div></div>'
         ].join('');
  };
  return {
    remove: removeHighlight,
    edit: editHighlight,
    clearFields: clearFields,
    generateHtml: generateHighlightHtml,
    empty: fieldEmpty
  }
};
