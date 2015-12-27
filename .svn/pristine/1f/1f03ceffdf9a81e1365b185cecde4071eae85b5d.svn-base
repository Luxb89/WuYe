$(document).ready(function() {
	$("#submit_btn").bind("click", saveRooms);
	
	var company = new CompanyObj("#pp_company").add(new ComunityObj("#community",{select: function(){
		$("#building").attr("disabled",false);
		$("#building").selectDiv("val",{communityId:$("#community").attr("data-id")});
	},init: function(){
		$("#building").attr("disabled",true);
	},clear:function(){
		$("#building").attr("disabled",true);
	}}));
	company.complete();
	
});
function addRow(num){
	
	$(".icon-plus").parent("#rooms a").attr("disabled","true").attr('href', 'javascript:void(0);');
	num = num+1;
	$("#rooms").append('<div class="row-fluid" id="room'+num+'">' +
			'										<div class="span3">' +
			'											<div class="control-group">' +
			'												<label class="tight-label" for="roomNbr">房间号</label>' +
			'												<div class="tight-control">' +
			'													<input type="text" style="width:100px" id="roomNbr" name="roomNbr"' +
			'														class=""> <span class="maroon">*</span>' +
			'												</div>' +
			'											</div>' +
			'										</div>' +
			'										<div class="span3">' +
			'											<div class="control-group">' +
			'												<label class="tight-label" for="ownerName">业主名称</label>' +
			'												<div class="tight-control">' +
			'													<input type="text" style="width:100px"  id="ownerName" name="ownerName">' +
			'												</div>' +
			'											</div>' +
			'										</div>' +
			'										<div class="span3">' +
			'											<div class="control-group">' +
			'												<label class="tight-label" for="ownerTel"' +
			'													style="display: inline">业主电话</label>' +
			'												<div class="tight-control">' +
			'													<input type="text" style="width:100px" id="ownerTel" name="ownerTel">' +
			'												</div>' +
			'											</div>' +
			'										</div>' +
			'										<div class="span2">' +
			'											<a class="btn" href="javascript:addRow('+num+')"><i class="icon-plus"></i>新增</a> <a class="btn" href="javascript:removeRow('+num+')"><i '+
			'												class="icon-minus"></i>删除</a> '+
			'										</div> '+
			'									</div> ');
	$("#building"+num+" select").append($("#building"+(num-1)+" option").clone());
}
function removeRow(num){
	var len = $("#rooms .row-fluid").length ;
	if (len != 1){
		if ($("#room"+num + " a:first").attr("disabled") == "disabled"){
			$("#room"+num).remove();
		}
	}
}
function saveRooms(){
	if (StrUtil.IsEmpty($(".proCitySelAll").data("buildingId"))){
		$.sucmodal("提示", "请选择楼栋");
		return;
	}
	var buildingId = $(".proCitySelAll").data("buildingId");
	var unitId = $(".proCitySelAll").data("unitId");
	var buildingName = $(".proCitySelAll").data("buildingName");
	var unitName = $(".proCitySelAll").data("unitName");
	var jsarray = new Array();
	
	var inparam = {data:{}};
	var isSave = true;
	$("#rooms .row-fluid").each(function(index,element){
		var roomNbr = $(this).find("input[name='roomNbr']").val();
		if (StrUtil.IsEmpty(roomNbr)){
			$.sucmodal("提示", "房间号不能为空");
			isSave = false;
			return false;
		}
		var ownerName = $(this).find("input[name='ownerName']").val();
		var ownerTel = $(this).find("input[name='ownerTel']").val();
		
		for (var i = 0; i < jsarray.length; i++){
			if (roomNbr == jsarray[i].roomNbr){
				$.sucmodal("提示", "房间号重复了");
				isSave = false;
				return false;
			}
		}
		var room = {
				building : {},
				partyInfo:{
					user:{}
				}
		};
		if (StrUtil.IsEmpty(unitId)){
			room.building.buildingId=buildingId;
		}else{
			room.building.buildingId=unitId;
		}
		
		room.roomNbr = roomNbr;
		if (!StrUtil.IsEmpty(ownerName)){
			room.partyInfo.partyName = ownerName;
		}
		if (!StrUtil.IsEmpty(ownerTel)){
			room.partyInfo.user.account = ownerTel;
		}
		
		jsarray.push(room);
		//building.buildingName = ;
	});
	
	if (!isSave){
		return;
	}
	
	inparam.data=jsarray;
	$.post("roomAction!saveRoom.action", {
		inParma : JSON.stringify(inparam)
	}, function(data) {
		data = eval("(" + data + ")");
		if (data.result == "true") {
			$.sucmodal("提示", data.msg, function() {
				location.href = "roomManager.jsp";
			});
		} else {
			alert("保存失败" + data.msg);
		}
	});
}

function clickOk(){
	if (StrUtil.IsEmpty($(".proCitySelAll").data("buildingId"))){
		$.sucmodal("提示", "请选择楼栋");
		return;
	}
	
	$("#desCompany").text($("#pp_company").val());
	$("#desCommunity").text($("#community").val());
	var buildingId = $(".proCitySelAll").data("buildingId");
	var unitId = $(".proCitySelAll").data("unitId");
	var buildingName = $(".proCitySelAll").data("buildingName");
	var unitName = $(".proCitySelAll").data("unitName");
	if (StrUtil.IsEmpty(unitId) && unitId != buildingId){
		$("#desBuilding").text(buildingName);
	}else{
		$("#desBuilding").text(buildingName+"-"+unitName);
	}
}
