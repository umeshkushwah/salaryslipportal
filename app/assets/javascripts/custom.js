function initializeTipsy(){
  $('.tipsy-tooltip').tipsy({gravity: 's'});  
}

$(document).ready(function(){

  $('.datepicker').datepicker({
    format: "dd/mm/yyyy",
    autoclose: true,
  }).on('changeDate', function (ev) {
    $(this).datepicker('hide');
  });

  initializeTipsy();

});






