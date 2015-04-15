// TODO 还需整理
var validator={
	errinput : 'errinput',
	errmsg : 'errmsg',
	errcls : 'no',
	yescls : 'yes',

	require : /[^(^\s*)|(\s*$)]/,
	email : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
	phone : /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/,
	mobile : /^((\(\d{3}\))|(\d{3}\-))?13[0-9]\d{8}?$|15[0-9]\d{8}?$/,
	url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,
	idCard : "this.isIdCard(value)",
	currency : /^\d+(\.\d+)?$/,
	number : /^\d+$/,
	zip : /^[1-9]\d{5}$/,
	ip  : /^[\d\.]{7,15}$/,
	qq : /^[1-9]\d{4,8}$/,
	integer : /^[-\+]?\d+$/,
	double : /^[-\+]?\d+(\.\d+)?$/,
	english : /^[A-Za-z]+$/,
	chinese : /^[\u0391-\uFFE5]+$/,
	userName : /^[a-z_ ]\w{3,}$/i,
	birthday : /^\d{4}-\d{1,2}-\d{1,2}$/,
	//unSafe : /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,
	unSafe : /[<>\?\#\$\*\&;\\\/\[\]\{\}=\(\)\.\^%,]/,
	//safeStr : /[^#\'\"~\.\*\$&;\\\/\|]/,
	isSafe : function(str){return !this.unSafe.test(str);},
	safeString : "this.isSafe(value)",
	filter : "this.doFilter(value)",
	limit : "this.checkLimit(value.strlen())",
	limitB : "this.checkLimit(this.LenB(value))",
	date : "this.isDate(value)",
	/*birthday : "this.checkBirthday(value)",*/
	repeat : "this.checkRepeat(value)",
	range : "this.checkRange(value)",
	compare : "this.checkCompare(value)",
	custom : "this.Exec(value)",
	group : "this.mustChecked()",
	ajax: "this.doajax(errindex)",
  strong: "this.isStrong(value)",
  firstname: /^[阿阿单阿跌阿伏干阿贺阿会阿勒根阿里阿鹿桓阿仑阿罗阿热阿史德阿史那阿思没阿勿嘀阿逸多哀哀骀蔼霭艾艾岁爱爱新觉罗暧安安迟安都安国安金安陵安平安期安丘安是安阳俺犴岸按昂盎敖奥奥敦奥鲁奥屯傲八巴巴公仈芭跋拔拔拔拔列拔列兰拔略拔也把把利杷罢罢敌霸白白狄白公白侯白鹿白鸾白马白冥白男白象白亚白杨提白乙百百里柏柏常柏高柏侯摆拜班班丘般阪阪泉阪上半办滨邦榜傍棒包苞苞丘褒雹保葆宝堡饱抱豹报暴鲍鲍丘鲍俎瀑杯卑卑梁卑徐悲碑北北宫北郭北海北旄北门北丘北人北唐北乡北殷北野贝倍倍俟孛孛术鲁邶背被备贲奔本崩伻甭泵逼鼻比比丘比人笔鄙彼必邲毕秘苾苾悉庇闭闭珊敝辟辟闾壁璧碧弼边编扁卞弁鴘汴变便辨辩标彪不麃表鳖别宾宾牟彬邠斌滨冰兵丙邴炳秉禀并并官波波斯剥拨略钵伯伯比伯常伯成伯德伯封伯丰伯高伯昏伯暋伯夏伯有伯州伯宗泊帛亳博勃驳马僰薄薄姑薄奚薄野卜卜成卜梁卜马捕补布布叔满部步步大汗步六孤步鹿根步叔步扬步温簿岑陈成程崔蔡庄曹车丛淳于晁巢单于常场厂策臣琮崇侯崇迟池楚储褚除春招出大但丁党邓刁戴杜董窦东东方东郭邸端木段都多电狄尔法樊范范姜方房费风封冯福扶符傅付公孙淦戈盖高葛耿龚苟辜顾关管郭国过甘桂刚干冮哈贺黑洪何河和胡虎宦黄侯候更呼延华花桓郝浩浑韩罕姬吉纪季简江姜蒋焦金靳晋荆鞠居剧具敬景井济翚计官阚康开柯孔隽寇邝匡蒯乐冷利刘力劳卢厉吕廖李林柳栗栾梁楼狼甪里稂练罗老蔺蓝兰赖路连闾丘陆费陆雷骆鲁鹿黎麻马买麦满莽毛茆茅冒茂枚梅门蒙孟弥祢糜米芈弭密秘苗缪闵敏名明万俟莫墨默牟母木沐慕慕容穆那纳迺佴南南宫难倪泥年念粘乜聂甯牛钮农侬区欧欧阳潘盘泮庞逄裴彭邳皮朴樸品平繁蒲濮浦普溥戚漆亓齐祁岐奇祈綦蕲麒乞杞启千钱强乔桥谯且郄钦秦琴覃勤青卿清庆丘秋邱仇求裘曲屈诎瞿璩渠蘧权全泉阙让任荣茹阮饶戎容山单上官佘申申屠沈盛施石史是世舒殳水司司马司徒死宋苏粟隋孙桑沙邵台邰谭檀谈汤唐陶滕田佟童涂庹完颜万汪王王子文闻闻人翁危委韦卫魏温文巫乌邬吴武午伍威勖奚袭席夏夏侯肖萧咸冼向项解谢信辛幸忻熊续徐许胥宣轩辕玄薛寻线鄢晏燕颜严言阎闫阳杨杨雷幺姚易叶页业移叶赫那拉殷阴银尹伊印胤应英婴营嬴郢游尤有于於余虞俞喻鱼禹庾玉育裕郁豫聿尉迟宇文宇宇文乐岳月云袁元原源员苑载昝臧糟迮笮曾查乍翟砦祭占詹瞻展湛战章彰张掌仉招肇赵兆召甄真镇征郑正政支职直植执治志郅智衷钟终仲周朱邾诸竺竹主祝专庄卓禚资訾紫子宗纵邹驺祖俎左佐][\u4E00-\u9FA5]+$/,

	isIdCard : function(number){
		var date, Ai;
		var verify = "10x98765432";
		var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
		var area = ['','','','','','','','','','','','北京','天津','河北','山西','内蒙古','','','','','','辽宁','吉林','黑龙江','','','','','','','','上海','江苏','浙江','安微','福建','江西','山东','','','','河南','湖北','湖南','广东','广西','海南','','','','重庆','四川','贵州','云南','西藏','','','','','','','陕西','甘肃','青海','宁夏','新疆','','','','','','台湾','','','','','','','','','','香港','澳门','','','','','','','','','国外'];
		var re = number.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/i);
		if(re == null) return false;
		if(re[1] >= area.length || area[re[1]] == "") return false;
		if(re[2].length == 12){
			Ai = number.substr(0, 17);
			date = [re[9], re[10], re[11]].join("-");
		} else {
			Ai = number.substr(0, 6) + "19" + number.substr(6);
			date = ["19" + re[4], re[5], re[6]].join("-");
		}
		if(!this.isDate(date, "ymd")) return false;
		var sum = 0;
		for(var i = 0;i<=16;i++){
			sum += Ai.charAt(i) * Wi[i];
		}
		Ai += verify.charAt(sum%11);

		return (number.length ==15 || number.length == 18 && number == Ai);
	},

	isDate : function(op){
		var formatString = this['element'].attr('format');
		formatString = formatString || "ymd";
		var m, year, month, day;
		switch(formatString){
		case "ymd" :
			m = op.match(new RegExp("^((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})$"));
			if(m == null ) return false;
			day = m[6];
			month = m[5]*1;
			year = (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
		break;
		case "dmy" :
			m = op.match(new RegExp("^(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))$"));
			if(m == null ) return false;
			day = m[1];
			month = m[3]*1;
			year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
		break;
		default :
			break;
		}
		if(!parseInt(month)) return false;
		month = month==0 ?12:month;
		var date = new Date(year, month-1, day);
		return (typeof(date) == "object" && year == date.getFullYear() && month == (date.getMonth()+1) && day == date.getDate());
		function GetFullYear(y){
			return ((y<30 ? "20" : "19") + y)|0;
		}
	}, //end isDate
	doFilter : function(value){
		var filter =this['element'].attr('accept');
		return new RegExp("^.+\.(?=EXT)(EXT)$".replace(/EXT/g,filter.split(/\s*,\s*/).join("|")),"gi").test(value);
	},

	checkLimit:function(len){
		var minval=this['element'].attr('min') ||Number.MIN_VALUE;
		var maxval=this['element'].attr('max') ||Number.MAX_VALUE;
		return (minval<= len && len<=maxval);

	},

	LenB : function(str){
		return str.replace(/[^\x00-\xff]/g,"**").length;
	},

	/*checkBirthday : function(value) {
		var tmp = [$('#user_birthday_1i').val(), $('#user_birthday_2i').val(), $('#user_birthday_3i').val()].join('-');
		$("#birthday").val(tmp);
		validator.birthday.test(tmp);
	},*/

	checkRepeat : function(value){
		var to = this['element'].attr('to');
		return value==jQuery('input[name="'+to+'"]').eq(0).val();
	},

	checkRange : function(value){
		value = value|0;
		var minval=this['element'].attr('min') || Number.MIN_VALUE;
		var maxval=this['element'].attr('max') || Number.MAX_VALUE;
		return (minval<=value && value<=maxval);
	},

	checkCompare : function(value){
		var compare=this['element'].attr('compare');
		if(isNaN(value)) return false;
		value = parseInt(value);
		return eval(value+compare);
	},

	Exec : function(value){
		var reg = this['element'].attr('regexp');
		return new RegExp(reg,"gi").test(value);
	},

	mustChecked : function(){
		var tagName=this['element'].attr('name');
		var f=this['element'].parents('form');
		var n=f.find('input[name="'+tagName+'"][checked]').length;
		var count = f.find('input[name="'+tagName+'"]').length;
		var minval=this['element'].attr('min') || 1;
		var maxval=this['element'].attr('max') || count;
		return (minval<=n && n<=maxval);
	},

  isStrong : function(value){
    return checkStrong($('#account_password').val()) != 'pw_check_1';
  },

	doajax : function(value) {
		var fk;
		var element = this['element'];
		var errindex = this['errindex'];
		var url=this['element'].attr('url');
		var mode = element.attr('mode') || 1 ;
		var msgid = element.attr('msgid');
		var val = this['element'].val();
		var str_errmsg=this['element'].attr('msg');
		var arr_errmsg = str_errmsg.indexOf('|') ? str_errmsg.split('|') :str_errmsg;
		var errmsg = arr_errmsg[errindex];
		var type=this['element'].attr('type');
		var errcls=this['errcls'];
		var yescls=this['yescls'];
    var realParam = this['element'].attr('real_param') ? this['element'].attr('real_param') : 'value';
		var param = val ?this['element'].attr('param') + '&' + realParam + '=' + val : this['element'].attr('param');	
		var Charset = jQuery.browser.msie ? document.charset : document.characterSet;
		var methodtype = (Charset.toLowerCase() == 'utf-8') ? 'post' : 'get';
		var method=this['element'].attr('method') || methodtype;
		var s = $.ajax({
			type: method,
			url: url,
			data: param,
			cache: false,
			async: false,
			success: function(data){
				data = data.replace(/(^\s*)|(\s*$)/g, "");
				   if(data != 'success')
				   {
					  errmsg = errmsg ? errmsg : data;
					  fk = false;
					  (type!='checkbox' && type!='radio' && element.addClass('errinput'));
					  if(mode == 1)
					  {
						  if(msgid) {
							  id = '#' + msgid;
							  $(id).removeClass('yes');
							  $(id).addClass('no');
							  $(id).html(errmsg);
						  } else {
							  jQuery("<span tag='err' class='"+errcls+"'></span>").html(errmsg).insertAfter(element);
						  }
					  } else if(mode == 2) {
						  alert(errmsg);
					  }
					  return false;
				   } else {
					   fk = true;
					   if(msgid) {
							id = '#' + msgid;
							$(id).removeClass('no');
							$(id).addClass('yes');
							$(id).html('');
						} else {
							jQuery("<span tag='err' class='"+yescls+"'>&nbsp;</span>").insertAfter(element);
						}
					  return true;
				   }
			   }
		 }).responseText;
		 s = s.replace(/(^\s*)|(\s*$)/g, "");
		 return s == 'success' ? true : false;
	}
};

validator.showErr=function (element, errindex){
	var str_errmsg=element.attr('msg') ||'unkonwn';
	var arr_errmsg = str_errmsg.split('|');
	var errmsg = arr_errmsg[errindex] ? arr_errmsg[errindex]: arr_errmsg[0];
	var mode = element.attr('mode') || 1;
	var msgid= element.attr('msgid');
	var type=element.attr('type');
	(type!='checkbox' && type!='radio' && element.addClass(this['errinput']));
	if(mode == 1)
	{
		if(msgid)
		{
			id = '#' + msgid;
			$(id).removeClass('yes');
			$(id).addClass('no');
			$(id).html(errmsg);
		}
		else
		{
			jQuery("<span tag='err' class='"+this['errcls']+"'></span>").html(errmsg).insertAfter(element);
		}
	}
	else
	{
		alert(errmsg);
	}
}

validator.removeErr =  function(element){
	element.removeClass(this['errinput']);
	element.parent('*').find('span[tag="err"]').remove();
}

validator.checkajax = function(element, datatype, errindex)
{
	var value=jQuery.trim(element.val());
	this['element'] = element;
	this['errindex'] = errindex;
	validator.removeErr(element);
	return eval(this[datatype]);
}

validator.checkDatatype = function(element,datatype){
	var value=jQuery.trim(element.val());
	this['element'] = element;
	validator.removeErr(element);
	switch(datatype){
		case "idCard" :
		case "date" :
		case "birthday" :
		case "repeat" :
		case "range" :
		case "compare" :
		case "custom" :
		case "group" :
		case "limit" :
		case "limitB" :
		case "safeString" :
		case "filter" :
    case "strong" :
		return eval(this[datatype]);
		break;

		default:
			return this[datatype].test(value);
			break;
		}
}

validator.check=function(obj){
	var datatype = obj.attr('datatype');
	if(typeof(datatype) == "undefined") return true;

	if(obj.attr('require')!="true" && obj.val()=="") return true;
	var datatypes = datatype.split('|');
	var ok = true;

	jQuery.each(datatypes,function(index,data){
		if(typeof(validator[data]) == "undefined") {
			ok = false;
			return  false;
		}
		if(data != 'ajax')
		{
			if(validator.checkDatatype(obj,data)==false){
				validator.showErr(obj, index);
				return ok=false;
			}
			else
			{
				var msgid= obj.attr('msgid');
				if(msgid)
				{
					id = '#' + msgid;
					$(id).removeClass('no');
					$(id).addClass('yes');
					$(id).html('');
				}
				else
				{

					jQuery("<span tag='err' class='yes'></span>").insertAfter(obj);
				}
			}
		}
		else
		{
			ok = validator.checkajax(obj, data, index);
		}
	});
	return ok;
}

jQuery.fn.checkForm = function(m){
	mode = (m==1) ? 1 : 0;
	var form=jQuery(this);
	var elements = form.find('input[require],select[require],textarea[require]');
	elements.blur(function(index){
		return validator.check(jQuery(this));
	});


	form.bind('submit.validator', function(){
		this.execute_history = 0;
		var ok = true;
		var errIndex= new Array();
		var n=0;
    elements = $(this).find('input[require],select[require],textarea[require]');
		elements.each(function(i){
			if(validator.check(jQuery(this))==false){
				ok = false;
				errIndex[n++]=i;
			};
		});

		if(ok==false){
			elements.eq(errIndex[0]).focus().select();
			return false;
		}
    
		if(document.getElementById('video_uploader') && !upLoading)
		{
			uploadFile();
			return false;
		}

    
		if($('#hava_checked').val()==0)
		{
			YP_checkform();
			return false;
		}
    if($(this).find('#need_birthday')[0]){
			var tmp = [$('#user_birthday_1i').val(), $('#user_birthday_2i').val(), $('#user_birthday_3i').val()].join('-');
			$("#birthday").val(tmp);
      if(validator.birthday.test(tmp)){
        if($('#need_birthday').parent().children('span').length) $('#need_birthday').parent().children('span').hide();
      }else{
        if(!$('#need_birthday').children('span').length) $('#need_birthday').parent().append('<span class="no" tag="err">请选择出生年月</span>');
        return false;
      }
    }
		this.execute_history = 1;
		return true;
	});
}

function CharMode(iN)
{
	if (iN>=65 && iN <= 90)
	return 2;
	if (iN>=97 && iN <= 122)
	return 4;
	else
	return 1;
	}

	function bitTotal(num)
	{
	modes = 0;
	for(i=0; i<3; i++)
	{
	if (num & 1) modes++;
	num >>>= 1;
	}
	return modes;
}

function checkStrong(sPW){
	Modes=0;

	for (i=0;i<sPW.length;i++){
		//测试每一个字符的类别并统计一共有多少种模式.
		Modes|=CharMode(sPW.charCodeAt(i));
		}
		var btotal = bitTotal(Modes);
		if (sPW.length >= 10) btotal++;
		switch(btotal) {
		case 1:
		return "pw_check_1";
		break;
		case 2:
		return "pw_check_2";
		break;
		case 3:
		return "pw_check_3";
		break;
		default:
		return "pw_check_1";
	}
}

function ShowStrong(){
	var data = checkStrong($('#reg_password').val());
	pw_id = '#' + data;
	$(".pw_check").hide();
	$(pw_id).show();
}
