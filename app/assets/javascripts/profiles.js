//= require attachinary

function testIt(e) {
  if(this.value.match(new RegExp(this.pattern))){
    this.style.cssText = null;
  }
  else {
    this.style.borderColor = "red";
  }
}

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  var profileAddress = document.getElementById('profile_address');
  var profilelat = document.getElementById('profile_lat');
  var profilelng = document.getElementById('profile_lng');

  profileAddress.blur();
  profileAddress.value = components.address + ', ' + components.zip_code + ' ' + components.city + ', ' + components.country_code;
  profilelat.value = place.geometry.location.lat();
  profilelng.value = place.geometry.location.lng();
  // if (components.country_code) {
  //   var selector = '#profile_country option[value="' + components.country_code + '"]';
  //   document.querySelector(selector).selected = true;
  // }
}

function getAddressComponents(place) {

  // console.log(place.geometry.location.lat());
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

  $('.attachinary-input').attachinary();

  var profileAddress = document.getElementById('profile_address');

  var profileName1 = document.getElementById('profile_mother_first_name');
  var profileName2 = document.getElementById('profile_father_first_name');
  var profileKids = document.getElementById('profile_kids');
  var profilePhone = document.getElementById('profile_phone');

  if(profileName1){
    profileName1.pattern = profileName2.pattern = patternName;
    profileKids.pattern = patternNumber;
  }

  if(profilePhone){
    profilePhone.pattern = patternPhone;
  }

  if (profileAddress) {
    var autocomplete = new google.maps.places.Autocomplete(profileAddress, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(profileAddress, 'keyup', function(e) {
      if (e.key === "Enter") {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }

  var inputs = [profileName1, profileName2, profileKids, profilePhone]

  // ES6 that crash assets precompile, wait for rails updates?
  // for (var value of inputs) {
  //   if (value) {
  //     value.addEventListener("keydown", testIt, true);
  //   }
  // }

  for(i = 0;i<inputs.length;i++) {
    if (inputs[i]) {
      inputs[i].addEventListener("keyup", testIt, true);
    }
  }

});


