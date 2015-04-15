(function($){
	$.fn.capacityFixed = function(options) {
		var opts = $.extend({},$.fn.capacityFixed.deflunt,options);
		var FixedFun = function(element) {
			var top = opts.top;
			var right = ($(window).width()-opts.pageWidth)/2+opts.right;
			element.css({
				"right":right,
				"top":top
			});
			$(window).resize(function(){
				var right = ($(window).width()-opts.pageWidth)/2+opts.right;
				element.css({
					"right":right
				});
			});
			$(window).scroll(function() {
				var scrolls = $(this).scrollTop();
				if (scrolls > top) {

					if (window.XMLHttpRequest) {
						element.css({
							position: "fixed",
							top: 0,
							zIndex:1,
							background:"#fff"
						});
					} else {
						element.css({
							top: scrolls
						});
					}
				}else {
					element.css({
						position: "absolute",
						top: top
					});
				}
			});
		};
		return $(this).each(function() {
			FixedFun($(this));
		});
	};

	$.fn.capacityFixed.deflunt={
		right :0,
		top:0,
		pageWidth : 1200
	};
})(jQuery);