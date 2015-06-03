

$(document.body).ready(function(){
	$('#search_form').submit(function(){
		$(this).find("input[name$='[like]']").each(function(){
			value = $.trim($(this).val());
			console.log(value) //在浏览器控制台输出日志
      // if (value != '' && !value.match(/\%/)) $(this).val('%'+value+'%');
		});

		$(this).find("input[type=text],select,textarea").each(function(){
			if ($.trim($(this).val()) == '') $(this).attr('disabled', true);
		});
		setTimeout($.proxy(function(){ $(this).find("input[type=text],select,textarea").each(function(){ $(this).attr('disabled', false); }); }, this), 100);
	});
});
