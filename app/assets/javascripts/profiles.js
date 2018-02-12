//= require attachinary
var patternName = /^[^0-9][\w'\-áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÉÈÊĒÀÄ][^0-9_!.¡?÷?¿+=@#$%^&*(){}|~<>;:\[\]]{0,}$/;
var patternNumber = /^\d+$/;
var patternPhone = /(0|\\+33|0033)[1-9][0-9]{8}/;


function testIt(input) {
  var input = this;
  setTimeout(function(){
  if(input.value.match(input.param)){
    input.style.cssText = null;
    console.log('correct');
  }
  else {
    input.style.borderColor = "red";
    console.log('bad');
  }
  }, 10);
}

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

  $('.attachinary-input').attachinary();

  var profileAddress = document.getElementById('profile_address');
  var profileName1 = document.getElementById('profile_mother_first_name');
  var profileName2 = document.getElementById('profile_father_first_name');
  var profilekids = document.getElementById('profile_kids');
  var profilephone = document.getElementById('profile_phone');

  if (profileAddress) {
    var autocomplete = new google.maps.places.Autocomplete(profileAddress, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(profileAddress, 'keydown', function(e) {
      if (e.key === "Enter") {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }

  if (profileName1) {
    profileName1.param = patternName;
    profileName1.addEventListener("keydown", testIt, true);
  }

  if (profileName2) {
    profileName2.param = patternName;
    profileName2.addEventListener("keydown", testIt, true);
  }

  if (profilekids) {
    profilekids.param = patternNumber;
    profilekids.addEventListener("keydown", testIt, true);
  }

  // if (profilephone) {
  //   profilephone.addEventListener("keydown", testIt, true);
  //   profilekids.param = patternPhone;
  // }
});


