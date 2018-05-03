var patternEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var patternEmails = /^[\W]*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]{2,4}[\W]*;{1}[\W]*)*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]{2,4})[\W]*$/
var patternName = "^[^0-9][\\w'\\-áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÉÈÊĒÀÄ][^0-9_!.¡?÷?¿+=@#$%^&*(){}|~<>;:\\[\\]]{0,}$";
var patternNumber = "^\\d+$";
var patternPhone = "^(0|\\+33|0033)[1-9][0-9]{8}$";

function testMail(e) {
  console.log("testMail");
  var input = this;
  input.style.color = "light-gray";

  setTimeout(function(){
    if(input.value.match(patternEmails)){
      input.style.cssText = null;
    }
    else if (input.value.length > 5) {
      input.style.borderColor = "red";
      input.style.color = "red";
    }
    else if (input.value.length == 0 ) {
      input.style.cssText = null;
    }
  }, 10);
}

document.addEventListener("DOMContentLoaded", function() {
  var profileEmail = document.getElementById('user_email');

  if (profileEmail) {
    profileEmail.addEventListener("keydown", testMail, false);
  }

});
