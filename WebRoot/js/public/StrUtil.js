/**
 * 
 */


function StrUtil(){
	
}
StrUtil.strnull = function(params){
	if (params == null || params == "null" || typeof(params) == "undefined"){
		return "";
	}else{
		return params;
	}
};

StrUtil.isEmpty = function(params){
	if (params == null || params=="" || params == "null" || typeof(params) == "undefined"){
		return true;
	}else{
		return false;
	}
}
/**
 * �ж��Ƿ�Ϊ������
 */
StrUtil.isPositiveInt = function(params){
	var re = /^[1-9]+[0-9]*]*$/; 
	  
    if (!StrUtil.isEmpty(params) && re.test(params))  
   {  
       return true;  
    }  else{
    	return false;
    }
}

/*
 * ;(function($, window, document,undefined) { //var strUtil = new StrUtil();
 * alert(StrUtil.Strnull("jin")); })(jQuery, window, document);
 */