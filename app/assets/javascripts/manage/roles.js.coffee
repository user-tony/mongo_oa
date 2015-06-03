# 权限页面 全选JS
$(document).ready ->
	$('#role_manage').on 'click', 'input', ->
		ths = $(this)
		num = 0
		for input_check in $('.'+ths.attr('action'))
			num += parseInt($(input_check).attr('value')) if $(input_check).prop( "checked" )
		$('#'+$(input_check).attr('action')).val(num)
		
$ ->
	$all = $('#role_manage .in-control')
	$classify_all = $('#role_manage .all')
	#页面加载判断
	$('input').each ->
		if $(this).val() == 127
			target = $(this).attr('id')
			$('[data-name=' + target + ']').prop 'checked', true
		return
	$all.click ->
		$('input').prop 'checked', @checked
		$val_input = $('.item .col-md-11>input')
		# console.log($val_input)
		$val_input.each ->
			target = $(this).attr('id')
			val_change target
			return
		return
	#分类全选
	$classify_all.click ->
		kind = $(this).attr('data-name')
		# var val = 0;
		$('[name=' + kind + ']').prop 'checked', @checked
		val_change kind
		input_checked $classify_all, $all
		return
	$('.item-detail').children().click ->
		name = $(this).children().attr('name')
		val = val_change(name)
		if val == 127
			$('[data-name=' + name + ']').prop 'checked', true
		else
			$('[data-name=' + name + ']').prop 'checked', false
		return
	#点击赋值

	val_change = (name) ->
		val = 0
		$('[name=' + name + ']:checkbox:checked').each ->
			val += parseInt($(this).val())
			return
		console.log val
		$('#' + name + '').attr 'value', val
		val

	#联动顶上的全选

	input_checked = (item, all) ->
		len = item.length
		i = 0
		item.each ->
			if $(this).prop('checked') == true
				i++
			return
		if i == len
			all.prop 'checked', true
		else
			all.prop 'checked', false
		return

	#背景色动画

	change_color = (dom) ->
		dom.css 'backgound-color', '#000'
		return

	return
$ ->
	$('.in-control1').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=1]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control2').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=2]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control3').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=4]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control4').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=8]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control5').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=16]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control6').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=32]').prop 'checked', @checked
		return
	return
$ ->
	$('.in-control7').click ->
		$(this).prop 'checked', @checked
		$('.item .item-detail [value=64]').prop 'checked', @checked
		return
	return
