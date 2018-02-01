$(document).ready(function() {
  $('.attachinary-input').attachinary();
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  var profileAddress = document.getElementById('profile_address');
  profileAddress.blur();
  profileAddress.value = components.address + ', ' + components.zip_code + ' ' + components.city + ', ' + components.country_code;

  // document.getElementById('profile_zip_code').value = components.zip_code;
  // document.getElementById('profile_city').value = components.city;

  if (components.country_code) {
    var selector = '#profile_country option[value="' + components.country_code + '"]';
    document.querySelector(selector).selected = true;
  }
}

function getAddressComponents(place) {
  // If you want lat/lng, you can look at:
  // - place.geometry.location.lat()
  // - place.geometry.location.lng()

  if (window.console && typeof console.log === "function") {
    console.log(place);
  }

  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type === 'street_number') {
        street_number = component.long_name;
      } else if (type === 'route') {
        route = component.long_name;
      } else if (type === 'postal_code') {
        zip_code = component.long_name;
      } else if (type === 'locality') {
        city = component.long_name;
      } else if (type === 'postal_town' && city === null) {
        city = component.long_name;
      } else if (type === 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number === null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}

document.addEventListener("DOMContentLoaded", function() {
  var profileAddress = document.getElementById('profile_address');

  if (profileAddress) {
    var autocomplete = new google.maps.places.Autocomplete(profileAddress, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(profileAddress, 'keydown', function(e) {
      if (e.key === "Enter") {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});


