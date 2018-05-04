const patternEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
const patternIdForEmail = /^([a-zA-Z0-9_\.\-])+/;
const patternEmails = /^[\W]*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]{2,4}[\W]*;{1}[\W]*)*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]{2,4})[\W]*$/
const patternName = "^[^0-9][\\w'\\-áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÉÈÊĒÀÄ][^0-9_!.¡?÷?¿+=@#$%^&*(){}|~<>;:\\[\\]]{0,}$";
const patternNumber = "^\\d+$";
const patternPhone = "^(0|\\+33|0033)[1-9][0-9]{8}$";

function testMail(e) {
  this.style.color = "light-gray";

  if(this.value.match(patternEmails)){
    this.style.cssText = null;
  }
  else if (!this.value.includes('@')) {
    if (this.value.match(patternIdForEmail)) {
      this.style.cssText = null;
    }
    else {
      this.style.borderColor = "red";
      this.style.color = "red";
    }
  }
  else if (this.value.includes('@')) {
    if (this.value.match(patternEmail)) {
      this.style.cssText = null;
    }
    else {
      this.style.borderColor = "red";
      this.style.color = "red";
    }
  }
  else if (this.value.length == 0 ) {
    this.style.cssText = null;
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const profileEmail = document.getElementById('user_email');

  if (profileEmail) {
    profileEmail.addEventListener("keyup", testMail, false);
  }
});
