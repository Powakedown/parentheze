document.addEventListener("DOMContentLoaded", function()  {
  $(window).scroll(function() {
    $("#animatedElement").each(function(){
    var imagePos = $(this).offset().top;

    var topOfWindow = $(window).scrollTop();
      if (imagePos < topOfWindow+400) {
        $(this).addClass("slideUp");
      }
    });
  });

  $(document).on("click", "a.scroll", function(event){
    event.preventDefault();

    $("html, body").animate({
        scrollTop: $( $.attr(this, "href") ).offset().top
    }, 500);
  });

  var submitMail = document.getElementById('submit_mail');
  var pattern = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  var emailField = document.getElementById('guest_email');
  var errorLabel = document.getElementById('hidden-error');

  function checkMailOnClick(e) {
    var input = this;

    if(emailField.value.match(pattern)){
      resetError(input, errorLabel);
    }
    else {
      e.preventDefault();
      displayError(emailField, errorLabel);
    }
  }

  function checkMailOnKeydown(e) {
    var input = this;
    input.style.color = "light-gray";

    setTimeout(function(){
      if(input.value.match(pattern)){
        resetError(input, errorLabel);
      }
      else if (input.value.length > 15) {
        displayError(input, errorLabel);
      }
      else if (input.value.length == 0) {
        resetError(input, errorLabel);
      }
    }, 10);
  }

  function displayError(field, label) {
    field.style.borderColor = "red";
    if (label) {
      label.style.display = "block";
    }
  }

  function resetError(field, label) {
    field.style.cssText = null;
    if (label) {
      label.style.display = null;
    }
  }

  submitMail.addEventListener("click", checkMailOnClick, true);

  if (submitMail) {
    emailField.addEventListener("keydown", checkMailOnKeydown, false);
  }
});
