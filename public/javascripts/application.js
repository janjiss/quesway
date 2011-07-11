$(document).ready(function() {
  // Hide or show collection of answers field on load
  hide_or_show_choices($('#question_category'));
  // Hide or show collection of answers field based upon a #question_answer_type_value
  $('#question_category').change(function() {
    hide_or_show_choices(this);
  });

});
//Function hides or displayes question answer collection based on select. If slecet is collection,
// it shows answers, else, they are hidden.
function hide_or_show_choices(select) {
  if ($(select).val() == "choices") {
    $("#choices").show();
  } else {
    $("#choices").hide();
  }
}

