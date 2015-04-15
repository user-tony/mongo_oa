$ ->
	$(document).on 'change', 'input[type=file]', ->
		if file = this.files && this.files[0]
			preview = $(this).closest('.form-group').find('.preview')
			preview.find('.file_name').text(file.name)
			
			
			preview.find('.file_size').text((u = $.grep([0,1,2,3,4,5,6,7,8,9], $.proxy(((i) -> Math.floor(this/Math.pow(1024,i+1)) == 0), file.size))[0]) && Math.floor(file.size/Math.pow(1024,u))+' '+['', 'K', 'M', 'G', 'T', 'P'][u]+'B')
			preview.find('.content_type').text(file.type)
			preview.find('.updated_at').text((d = new Date()) && (d.getFullYear()+'-'+('0'+(d.getMonth()+1)).slice(-2)+'-'+('0'+(d.getDate())).slice(-2)+' '+('0'+(d.getHours())).slice(-2)+':'+('0'+(d.getMinutes())).slice(-2)+':'+('0'+(d.getSeconds())).slice(-2)+''))
			if file.type.match(/image.*/)
				a = preview.find('.image').removeAttr('href').off('click')
				img = a.find('img')
				img = $('#'+$(this).attr('id')+'_preview img') if !img.length
				if (URL = window.URL || window.webkitURL) && URL.createObjectURL
					src = URL.createObjectURL(file)
					img.attr('src', src)
					image = new Image()
					image.src = src
					image.onload = $.proxy((->
						this.preview.find('.image_width').text(this.image.width)
						this.preview.find('.image_height').text(this.image.height)
					), { preview: preview, image: image })
