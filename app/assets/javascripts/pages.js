document.addEventListener("DOMContentLoaded", function()  {

  //SCROLLER

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


  // REGEX MAIL

  var submitMail = document.getElementById('submit_mail');
  var emailFields = document.getElementsByClassName('email-field');
  var errorLabel = document.getElementById('hidden-error');

  submitMail.addEventListener("click", checkMailOnClick, true);

  for(i = 0;i<emailFields.length;i++) {
    if (emailFields[i]) {
      emailFields[i].addEventListener("keydown", checkMailOnKeydown, true);
    }
  }

  function checkMailOnClick(e) {
    var submit = this;

    if(emailFields[1].value.match(patternEmail)){
      resetError(submit, errorLabel);
    }
    else {
      e.preventDefault();
      displayError(emailFields[1], errorLabel);
    }
  }

  function checkMailOnKeydown(e) {
    var input = this;
    input.style.color = "light-gray";
    setTimeout(function(){
      if(input.value.match(patternEmail)){
        resetError(input, errorLabel);
      }
      else if (input.value.length == 0) {
        resetError(input, errorLabel);
      }
      else if (input.value.length > 12) {
        displayError(input, errorLabel);
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

});
