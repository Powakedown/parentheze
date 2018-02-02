var current_question = <%= session[:current_question] %>
$('#breadcrumb-question'+current_question).addClass('active');

for (i = 1; i <= <%= @questions_number %> ; i++) {
  $('#question'+i).hide();
}

$('#question'+current_question).show();
