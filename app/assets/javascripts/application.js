//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require flash

var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;

function testMail(e) {
  if(this.value.match(pattern)){
    this.style.cssText = null;
  }
  else if (this.value.length > 3) {
    this.style.borderColor = "red";
  }
}

document.addEventListener("DOMContentLoaded", function() {
  var profileEmail = document.getElementById('user_email');

  if (profileEmail) {
    profileEmail.addEventListener("keydown", testMail, false);
  }

});


