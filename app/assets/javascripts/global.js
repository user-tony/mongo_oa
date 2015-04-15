$(function(){
// 焦点图
	$(window).load(function() {
		$('.flexslider').flexslider({
			//animation: "slide",
			animation: "fade",
			pauseOnHover: true,
			touch: true
		});
	});

//	head搜索
	var headerSelect = $('.header_select');
	var headerSelectUl = headerSelect.find('ul');
	var searchkey = $('.header_select_sort').find('em');
	headerSelect.hover(function(){
		headerSelectUl.show();
	},function(){
		headerSelectUl.hide();
	});
	headerSelectUl.find('li').on("click", function () {
		var sName = $(this).find('a').text();
		var skey = $(this).find('a').data('name');
		searchkey.text(sName);
		$("#flag").val(skey);
		$(this).closest('.header_select').find('ul').hide();
	});


//首页焦点图申请服务滚动及案例右侧滚动
	var marquee1 = $('.marquee');
	var marquee2 = $('.new-serviced-wrap');
	var marquee3 = $('.tutor-slide-wrap');
	marquee1.marquee({
		auto: true,
		interval: 7000,
		speed: 1500,
		type: 'vertical'
	});
	marquee2.marquee({
		auto: true,
		interval: 7000,
		showNum: 8,
		speed: 1500,
		stepLen: 1,
		type: 'vertical'
	});

//留学规划师
	marquee3.marquee({
		auto: true,
		interval: 7000,
		showNum: 6,
		speed: 1500,
		stepLen: 1,
		type: 'vertical'
	});
	

	$(document).on({
		submit: function(){
			name = $(this).find('#student_name').val()
			phone = $(this).find('#student_phone').val()
			operate = $(this).find('#student_operate').val()
			if (name == 0) {
				$(this).find('.error_name').html('称呼不能为空').show();
				return;
			}
			if (phone == 0) {
				$(this).find('.error_phone').html('手机号不能为空')
				$(this).find('.error_name').hide()
				return
			}
			if (!/^1\d{10}$/.test(phone)) {
				$(this).find('.error_name').hide()
				$(this).find('.error_phone').html('请输入正确的手机号');
				return;
			}
			$.ajax({
				url: "/students",
				type: 'post',
				dataType: 'json',
				data: {'student[name]': name, 'student[phone]': phone, 'student[operate]': operate },
				context: this,
				success: function(data) {
					$('.server-bg,.error_phone').hide();
					if (data.errors){
						alert('请填写真实有效的内容')
					} else {
						$(this).find('#student_name').val('')
						$(this).find('#student_phone').val('')
						$('.popupContainer-bg').show()
					}
				}
			})
		}
	}, 'form.popover_operate')

	$(document).on({
		submit: function(){
			name = $(this).find('#feedback_name').val()
			phone = $(this).find('#feedback_phone').val()
			content = $(this).find('#feedback_content').val()
			if (name == 0) {
				$(this).find('.error_name').html('称呼不能为空').show();
				return;
			}
			if (phone == 0) {
				$(this).find('.error_name').hide()
				$(this).find('.error_phone').html('手机号不能为空').show();
				return;
			}
			if (!/^1\d{10}$/.test(phone)) {
				$(this).find('.error_name').hide()
				$(this).find('.error_phone').html('请输入正确的手机号').show();
				return;
			}
			if (content == 0) {
				$(this).find('.error_name, .error_phone').hide()
				$(this).find('.error_content').html('请填写有效的内容');
				return;
			}
			$.ajax({
				url: "/feedbacks",
				type: 'post',
				dataType: 'json',
				data: {'feedback[name]': name, 'feedback[phone]': phone, 'feedback[content]': content },
				context: this,
				success: function(data) {
					$('.feedback-bg').hide();
					if (data.errors) {
						alert('请填写完整有效的内容')
					}else{
						$(this).find('#feedback_name').val('')
						$(this).find('#feedback_phone').val('')
						$(this).find('#feedback_content').val('')
						$('.success-bg').show();
					}
				}
			})
		}
	}, 'form#feedback_form')

//	意见反馈
	var feedback = $(".ico-feedback, .top-feedback");
	feedback.on('click',function(){
		$('.feedback-bg').show();
		$('.error_name,.error_phone').html('')
	});

//	弹框咨询等
	var popover = $(".popover-server, .ico-server, .ico-guide");
	popover.on('click',function(){
		$('.server-bg').show();
		$('.error_name,.error_phone').html('')
	});
	var close_popover = $(".closeit");
	close_popover.on('click',function(){
		$(this).closest('.feedback-bg,.popupContainer-bg,.server-bg,.success-bg,.chengdou-bg').hide();
	});

	$('.chengdu').on('click', function(){
		$('.chengdou-bg').show();
	});

//资讯tab切换
	var newstab = $(".tabbtn");
	var guidetab = $(".tab-guide");
	newstab.tabso({
		cntSelect:".leftcon",
		tabEvent:"mouseover",
		tabStyle:"move-animate",
		direction : "left"
	});

//留学指导步骤切换
	guidetab.tabso({
		cntSelect:".leftcon",
		tabEvent:"click",
		tabStyle:"move-animate",
		direction : "left"
	});

//留学指导侧栏
	var sider_nav = $(".js_sider_nav");
	sider_nav.click(function() {
		$(this).next(".js_sider_wrap").slideToggle().siblings(".js_sider_wrap").slideUp();
		$(this).toggleClass("selected");
		$(this).siblings(".js_sider_nav").removeClass("selected");
	});


//首页机构切换
	$(".orgs-logo").hover(function() {
		$(this).next(".orgs-show").stop().show().siblings(".orgs-show").stop().hide();
		$(this).addClass("selected").siblings(".orgs-logo").removeClass("selected");
	});

//首页案例切换
	$(".small-photo .js_ctrl").hover(function() {
		$(this).next(".show-large").stop().show().siblings(".show-large").stop().hide();
		$(this).toggleClass("opacity-it");
	});


//浏览器提示
	$("#IEtest").append("<div class='revision'><p>非常抱歉, 您的浏览器内核版本过低。<br />为了更好的浏览体验, 以及为了您自身电脑的安全性, <br />我们建议您升级到最新版本或选择另一个web浏览器!<br />" +
	"<a href='http://www.google.cn/intl/zh-CN/chrome/browser/'  target='_blank' class='chrome'>谷歌浏览器</a>" +
	"<a href='http://firefox.com.cn/download/' target='_blank' class='firefox'>火狐浏览器</a>" +
	"<a href='http://download.microsoft.com/download/4/C/A/4CA9248C-C09D-43D3-B627-76B0F6EBCD5E/IE9-Windows7-x86-chs.exe' title='IE 9 浏览器下载' target='_blank' class='ie9'>IE9浏览器</a>" +
	"<a href='http://download.microsoft.com/download/4/1/4/4149BFB1-AC27-401D-943F-DA1BBD0537C5/IE10-Windows6.1-x86-zh-cn.exe' title='IE 10 浏览器下载' target='_blank' class='ie10'>IE10浏览器</a>" +
	"</p></div>");
});


//	返回顶部
function initGoToTop() {
	jQuery(function () {
		if (jQuery(window).width() < 1340) {
			jQuery("#backtotop").addClass('fix-left');
		} else {
			jQuery("#backtotop").removeClass('fix-left');
		}
		jQuery(window).resize(function(){
			if (jQuery(window).width() < 1340) {
				jQuery("#backtotop").addClass('fix-left');
			} else {
				jQuery("#backtotop").removeClass('fix-left');
			}
		});

		jQuery(window).scroll(function () {
			if (jQuery(this).scrollTop() > 600) {
				jQuery('#backtotop').addClass('showme');
			} else {
				jQuery('#backtotop').removeClass('showme');
			}
		});

		// scroll body to 0px on click
		jQuery('.ico-to-top').click(function () {
			jQuery('body,html').animate({
				scrollTop: 0
			},  400);
			return false;
		});
	});

	if (jQuery(window).scrollTop() == 0) {
		jQuery('#backtotop').removeClass('showme');
	}else{
		jQuery('#backtotop').addClass('showme');
	}
}
initGoToTop();


var today       = new Date();				//获得当前日期
var year        = today.getFullYear();		//获得年份
var month       = today.getMonth() + 1;		//此方法获得的月份是从0---11, 所以要加1才是当前月份
var day         = today.getDate();			//获得当前日期
var minutes     = today.getMinutes();		//获取当前分钟数(0-59)
var second      = today.getSeconds();		//获取当前秒数(0-59)
var millisecond = today.getMilliseconds();  //获取当前毫秒数(0-1000)

var infos = '千帆渡 | 您身边的留学教育专家'+ '    ' + '孙波 '+' 佟立家 '+' 胡钰源 '+' 王玉成 ' + '    ' + year + '年' + month + '月' + day + '日 '+ minutes + '分' + second + '秒'+ millisecond + '毫秒';
console.info("%s",infos);
