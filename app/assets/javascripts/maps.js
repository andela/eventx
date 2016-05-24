$(function () {
  google.maps.event.addDomListener(window, 'load', initialize);
});
function geocode(address, fn) {
  var geocoder = new google.maps.Geocoder();
  var position = {
    lat: null,
    lng: null
  };
  geocoder.geocode({ 'address': address }, function (results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var result = results[0].geometry.location;
      position.lat = result.lat();
      position.lng = result.lng();
      fn(position);
    }
  });
  return;
}
function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(-33.8688, 151.2195),
    zoom: 13
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var input = document.getElementById('event_location');
  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);
  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });
  var events = all_events();
  _.forEach(events, function (event) {
    var infowindow = new google.maps.InfoWindow({
      content: infoHtml(event),
      maxWidth: 400
    });
    geocode(event.location, function (position) {
      var marker = new google.maps.Marker({
        map: map,
        position: position,
        title: event.title,
        label: event.title
      });
      infowindow.open(map, marker);
    });
  });
  google.maps.event.addListener(autocomplete, 'place_changed', function () {
    infowindow.close();
    marker.setVisible(true);
    var place = autocomplete.getPlace();
    //var c = document.getElementById('event_map_url').value = place.url.indexOf('plus') > 0 ? 'https://maps.google.com/maps/place?q=' + document.querySelector('#event_location').value.replace(/\s/g, '+') : place.url;
    if (!place.geometry) {
      window.alert('Autocomplete\'s returned place contains no geometry');
      return;
    }
    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setIcon({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    });
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
    var address = '';
    if (place.address_components) {
      address = [
        place.address_components[0] && place.address_components[0].short_name || '',
        place.address_components[1] && place.address_components[1].short_name || '',
        place.address_components[2] && place.address_components[2].short_name || ''
      ].join(' ');
    }
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });
  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.
  function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    google.maps.event.addDomListener(radioButton, 'click', function () {
      autocomplete.setTypes(types);
    });
  }
  setupClickListener('changetype-all', []);
  setupClickListener('changetype-address', ['address']);
  setupClickListener('changetype-establishment', ['establishment']);
  setupClickListener('changetype-geocode', ['geocode']);
}