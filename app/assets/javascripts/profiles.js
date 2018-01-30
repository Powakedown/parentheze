//   window.onload = function() {
//   var current_step = 2;
//   target_step = document.getElementById('breadcrumb-step'+current_step)
//   target_step.className += " active";

//   let submits = document.getElementsByClassName( 'login-button' );
//   let comebacks = document.getElementsByClassName( 'previous' );

//   for (i = 2; i <= 5 ; i++) {
//     if( i != current_step){
//       document.getElementById('screen'+i).style.display = 'none';
//     }
//   }

//   for ( let comeback of comebacks) {
//     comeback.onclick = function() {
//       step(this,-1)
//     }
//   }

//   for ( let submit of submits ) {
//     submit.onclick = function() {
//       step(this, 1);
//     }
//   }

//   var step = function(button, target) {
//     current_step = button.id.charAt(button.id.length-1)
//     target_step_dot = document.getElementById('breadcrumb-step'+(parseInt(current_step)+target))
//     current_step_dot = document.getElementById('breadcrumb-step'+parseInt(current_step))
//     target_step_dot.className = "step flexbox active";
//     current_step_dot.className = "step flexbox";

//     document.getElementById('screen'+current_step).style.display = 'none';
//     document.getElementById('screen'+(parseInt(current_step)+target)).style.display = 'block';
//   }
// };

$(document).ready(function() {
  $('.attachinary-input').attachinary();
});


