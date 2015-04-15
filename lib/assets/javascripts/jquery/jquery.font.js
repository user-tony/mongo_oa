(function($) {
	$.font = {
		id: "__jQuery_font",
		settings: {
			timeout: 60000,
			interval: 500,
			chars: 'ABCDEFGabcdefg123',
			defaultFont: 'null'
		},
		target: null,
		dimesion: null,
		timer: null,
		counter: 0,
		init: function() { },
		load: function(target, name) {
			this.target = target;
			if (!$('#'+this.id).length) $('body').append('<span style="position:absolute;top:-999px;left:-999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;display:none;font-family:'+this.settings.defaultFont+';" id="'+this.id+'">'+this.settings.chars+'</span>');
			this.dimesion = $('#'+this.id).width()+'x'+$('#'+this.id).height();
			$('#'+this.id).css('font-family', name);
			this.timer = setInterval($.proxy(this.check, this), this.settings.interval);
		},
		check: function() {
			this.counter = this.counter + 1;
			if (this.counter > this.settings.timeout/this.settings.interval) { clearInterval(this.timer); return; }
			if ($('#'+this.id).width()+'x'+$('#'+this.id).height() != this.dimesion) { clearInterval(this.timer); $(this.target).css('font-family', $('#'+this.id).css('font-family')); }
		}
	};
})(jQuery);
