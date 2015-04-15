$(document).ready ->

	# 全站搜索
	event_all_search = (input, content_ul) ->
		$.ajax({
			dataType: "json",
			url: '/common/interfaces/search',
			data: { keyword: input.val()||"*:*", limit: input.attr('data-limit'), trim: input.attr('data-trim') },
			success: (data) ->
				content_ul.empty()
				for doc in data
					if doc.count >0
						content_ul.append '<li><a target="_blank" href="/searches?keyword='+input.val()+'"><span class="pull-right">'+doc.count+'结果</span>'+doc.title+'</a></li>'
				content_ul.append '<li><a href="/searches" target="_blank" class="result-count">查看全部</a></li>'
		 })

	# input_keyword = $('.search_cont #keyword')
	# search_result = $('#result', input_keyword.parents('.search_cont'))
	# search_result_ul = $('ul', search_result)

	# input_keyword.focus ->
	# 	if input_keyword.val() != ''
	# 		event_all_search(input, search_result_ul)
	# 		search_result.removeClass('hide')
	# input_keyword.focusout ->
	# 	setTimeout( ->
	# 		search_result.addClass('hide')
	# 	, 100 )
	# input_keyword.keyup ->
	# 	if search_result.hasClass('hide') then search_result.removeClass('hide')
	# 	if input_keyword.val().length > 1
	# 		event_all_search(input_keyword, search_result_ul)
	# 	else
	# 		search_result.addClass('hide')

	# 问答页搜索
	event_search = (input, content_ul) ->
		$.ajax({
			dataType: "json",
			url: input.attr('data-url'),
			data: { keyword: input.val()||"*:*", limit: input.attr('data-limit'), trim: input.attr('data-trim') },
			success: (data) ->
				content_ul.empty()
				for doc in data.docs
          content_ul.append '<li><a href="/questions/'+doc.id+'">'+'<span class="pull-right">'+doc.views_count+'人查看'+'</span>'+doc.title+'</a></li>'
				if data.numFound > 1
					content_ul.append '<li><a href="/qeustions/list" class="result-count">查看更多('+data.numFound+')</a></li>'
				else
					content_ul.append '<li><a href="/questions/list" class="result-count">没有相关问题，查看更多</a></li>'

				for text in input.val().split(' ')
					$(".result ul li").highlight(text)
		 })

	input = $('.container #keyword')
	result_ul = $('.container #result ul')

	# input.focus ->
	# 	event_search(input, result_ul)
	# 	$('.container .result').removeClass('hide')
	# input.focusout ->
	# 	setTimeout( ->
	# 		$('.container .result').addClass('hide')
	# 	, 100 )
	# input.keyup ->
	# 	if $('.container #result').hasClass('hide') then $('.container #result').removeClass('hide')
	# 	if input.val().length > 1
	# 		event_search(input, result_ul)
	# 	else
	# 		$('.container .result').addClass('hide')
