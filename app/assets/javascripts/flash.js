window.setTimeout(function(){
  $(".alert").addClass("slideRight-away");
  setTimeout(function(){
    $(".alert").hide();
  }, 1000);
}, 5000);
