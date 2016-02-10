
$(document).ready(function(){
  $('.datepicker').datepicker({
    format: "dd/mm/yyyy",
    autoclose: true,
  }).on('changeDate', function (ev) {
    $(this).datepicker('hide');
  });;
});


$('#tipsy-tooltip').tipsy({
  title: function() {
    return this.getAttribute('original-title').toUpperCase();
  }
});




