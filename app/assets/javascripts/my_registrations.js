
var pattern = /^([\w\.][^_])+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;

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

function hideErrors(e) {
  // var input = this;
  // errorMessages = document.getElementsByClassName('help-block');
  // console.log('focus');
  // for (var value of errorMessages) {
  //   value.style.display = "none";
  // }
}

document.addEventListener("DOMContentLoaded", function() {
  var profileEmail = document.getElementById('user_email');

  if (profileEmail) {
    profileEmail.addEventListener("keydown", testMail, false);
    profileEmail.addEventListener("focus", hideErrors, false);
  }

});
