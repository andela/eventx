function highLight() {
  var fields = [
      'id',
      '_destroy',
      'day',
      'title',
      'description',
      'start_time',
      'end_time',
      'image',
      'image_title'
    ], deletedFields = [
      'id',
      '_destroy'
    ];
  function removeHighlight(ele) {
    var deleteHighlight = confirm('Are you sure?');
    ele = ele.closest('li');
    if (deleteHighlight) {
      try {
        var highlightIndex = ele.find('input[name*=index]')[0].value;
        createDeletedFields(ele, highlightIndex);
      } catch (e) {
      } finally {
        ele.remove();
      }
    }
  }
  function editHighlight(ele) {
    $('#highlight_field_new').toggleClass('hide').show();
    var values = fetchValues(ele);
    populateFields(values);
    ele.closest('li').remove();
  }
  function createDeletedFields(ele, highlight_count) {
    var data = {};
    data.id = ele.find('[name*=id]').val();
    data._destroy = 1;
    $('#event_highlights').append(deletedHighlightHtml(data, highlight_count));
  }
  function fetchValues(ele) {
    var collapsibleHeader = ele.closest('.collapsible-header');
    saveImage(collapsibleHeader);
    return _.map(fields, function (name) {
      return [
        name,
        collapsibleHeader.siblings('.ha').find('[name*=' + name + ']')[0].value
      ];
    });
  }
  function populateFields(collapsibleData) {
    collapsibleData = _.fromPairs(collapsibleData);
    var hfield = $('#highlight_field_new').children(), tag = '.highlight_';
    _.forEach(collapsibleData, function (value, key) {
      hfield.find(tag + key).val(value);
    });
  }
  function saveImage(ele) {
    var image = ele.siblings('.collapsible-body').find('#img').attr('src');
    localStorage.setItem('highlight_photo_upload', image);
  }
  function fieldEmpty() {
    var data = hightlightData();
    delete data.image_title;
    delete data.image;
    delete data.id;
    delete data._destroy;
    var arr = _.toArray(data);
    return arr.some(function (value) {
      return value === '';
    });
  }
  function clearFields() {
    var hfield = $('#highlight_field_new').children(), tag = '.highlight_';
    _.forEach(fields, function (value) {
      hfield.find(tag + value).val('');
    });
  }
  function hightlightData() {
    var hfield = $('#highlight_field_new').children(), tag = '.highlight_', data = {};
    _.forEach(fields, function (value) {
      data[value] = _.escape(hfield.find(tag + value).val());
    });
    data.image = localStorage.getItem('highlight_photo_upload');
    return data;
  }
  function generateHighlightHtml(highlight_count) {
    var data = hightlightData();
    return accordionItemHtml(data) + hiddenFieldHtml(data, highlight_count);
  }
  function hiddenFieldHtml(data, highlight_count) {
    var html = _.map(fields, function (value) {
      return [
        '<input type=\'hidden\' name = \'event[highlights_attributes][',
        highlight_count,
        '][',
        value,
        ']\' value=\'',
        data[value],
        '\'>'
      ].join('');
    });
    return '<div class=\'ha\'>' + _.join(html, '') + '</div>';
  }
  function deletedHighlightHtml(data, highlight_count) {
    var html = _.map(deletedFields, function (value) {
      return [
        '<input type=\'hidden\' name = \'event[highlights_attributes][',
        highlight_count,
        '][',
        value,
        ']\' value=\'',
        data[value],
        '\'>'
      ].join('');
    });
    return _.join(html, '');
  }
  function accordionItemHtml(data) {
    return [
      '<div class="collapsible-header">',
      data.day + ' - ' + data.title,
      '<span class="right">',
      data.start_time,
      ' - ',
      data.end_time,
      '<span class="right remove-highlight" onclick="highLight().remove($(this))"><i class="material-icons">delete</i></span>',
      '<span class="right edit-highlight" onclick="highLight().edit($(this))"><i class="material-icons">edit</i></span>',
      '</span></div>',
      '<div class="collapsible-body"> <div class="row">',
      '<div class="col l6 m6">',
      '<div class="card-panel">',
      '<img id="img" class="materialboxed" width="100%" data-caption="',
      data.image_title + '"',
      'src="' + data.image + '"/>',
      '</div></div><div class="col l6">',
      '<p>' + data.description + '</p>',
      '</div></div></div>'
    ].join('');
  }
  return {
    remove: removeHighlight,
    edit: editHighlight,
    clearFields: clearFields,
    generateHtml: generateHighlightHtml,
    empty: fieldEmpty
  };
}