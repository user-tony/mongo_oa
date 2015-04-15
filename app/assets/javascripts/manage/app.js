

$(document.body).ready(function(){
	$('#search_form').submit(function(){
		$(this).find("input[name$='[like]']").each(function(){
			value = $.trim($(this).val());
			console.log(value)
      // if (value != '' && !value.match(/\%/)) $(this).val('%'+value+'%');
		});

		$(this).find("input[type=text],select,textarea").each(function(){
			if ($.trim($(this).val()) == '') $(this).attr('disabled', true);
		});
		setTimeout($.proxy(function(){ $(this).find("input[type=text],select,textarea").each(function(){ $(this).attr('disabled', false); }); }, this), 100);
	});


	$('.hasDatepicker').datetimepicker({
    lang:'ch',
    timepicker: false,
    format:'Y-m-d',
    step: 10
  });
	$('.hasDatepicker').datepicker({ altFormat: 'yy-mm-dd' });

	// timepicker('option', {dateFormat: 'yy-mm-dd'});
});
