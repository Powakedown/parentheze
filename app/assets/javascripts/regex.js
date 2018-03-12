var pattern = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

function testMail(e) {
  var input = this;
  input.style.color = "light-gray";

  setTimeout(function(){

    if(input.value.match(pattern)){
      input.style.cssText = null;
    }
    else if (input.value.length > 5) {
      input.style.borderColor = "red";
    }
  }, 10);
}

document.addEventListener("DOMContentLoaded", function() {
  var profileEmail = document.getElementById('user_email');

  if (profileEmail) {
    profileEmail.addEventListener("keydown", testMail, false);
  }

});
