/**
 * 控制器
 * 
 * @author tanyw
 */
var acctItemRelApp = angular.module("acctItemRelApp", ["commonApp","costSettingServiceApp","directiveUtilApp", "propertyServiceApp"]);

acctItemRelApp.controller("acctItemRelController", [ "$scope", "commonService","costSettingService",
		"propertyService", "$timeout", "$log","DirectiveUtil","$compile",
		function($scope, commonService,costSettingService, propertyService, $timeout, $log,DirectiveUtil,$compile) {
	
		//加载出错，弹出提示框
	    $scope.isSuccess = true;
	    $scope.$watch('isSuccess',function(nv,ov){
			if(!nv){
				$scope.isSuccess = true;
			    MESSAGE_DIALOG.error("出错了！");
			    setTimeout(function(){MESSAGE_DIALOG.close()},2000);
			}
	    });
	    $scope.addRow=function(obj){
	    	var randStr=Date.parse(new Date());
	    	var dirctBuilder =null;
	    	//tr
	    	var tr=$("<tr class='row-fluid accItemRelRow' id='accItemRelRow'"+randStr+"></tr>");
	    	var td = $('<td width="20%"></td>');
	    	//label
	    	dirctBuilder=$('<label class="defind-label">费用大类</label>');
	    	td.append(dirctBuilder);
	    	//创建select
	    	dirctBuilder = new DirectiveUtil.DirectiveBuilder('select');
			dirctBuilder.appendAttr('style', 'width: 50%')     // $scope.isNew, $scope.showAddBtn, $scope.initData  
		    .appendAttr('ng-model', "acctItemTypeUp"+randStr+".acctItemTypeId")  
		    .appendAttr('ng-change', "queryAcctItemType(acctItemTypeUp"+randStr+".acctItemTypeId,"+randStr+")")
		    .appendAttr("ng-options","acctItemTypeUp"+randStr+".acctItemTypeId as acctItemTypeUp"+randStr+".acctTypeName for acctItemTypeUp"+randStr+" in acctItemTypeUps"+randStr); 
			
			tr.append(td.append(dirctBuilder.build($compile, $scope)));
			td=$('<td width="20%"></td>');
			dirctBuilder=$('<label class="defind-label">费用细类</label>');
	    	td.append(dirctBuilder);
	    	
	    	//创建select
	    	dirctBuilder = new DirectiveUtil.DirectiveBuilder('select');
			dirctBuilder.appendAttr('style', 'width: 50%')     // $scope.isNew, $scope.showAddBtn, $scope.initData  
		    .appendAttr('ng-model', "acctItemType"+randStr+".acctItemTypeId")
		    .appendAttr('ng-change', "queryCaculateMethod(acctItemType"+randStr+".acctItemTypeId,"+randStr+")")
		    .appendAttr("ng-options","acctItemType"+randStr+".acctItemTypeId as acctItemType"+randStr+".acctTypeName for acctItemType"+randStr+" in acctItemTypes"+randStr); 
			tr.append(td.append(dirctBuilder.build($compile, $scope)));
			
			td=$('<td width="20%"></td>');
			dirctBuilder=$('<label class="defind-label">收费标准</label>');
	    	td.append(dirctBuilder);
	    	dirctBuilder=new DirectiveUtil.DirectiveBuilder('input');
	    	dirctBuilder.appendAttr('type',"text")
	    	.appendAttr('ng-model','acctItemRel'+randStr+'.price')
	    	.appendAttr('style','width: 50%');
	    		//$('<input type="text" id="price" style="width: 50%">');
	    	td.append(dirctBuilder.build($compile, $scope));
	    	tr.append(td);
	    	$("#acctItemTypes").append(tr);
	    	
	    	td=$('<td width="20%"></td>');
			dirctBuilder=$('<label class="defind-label">计算方法</label>');
	    	td.append(dirctBuilder);
	    	dirctBuilder=new DirectiveUtil.DirectiveBuilder('select');
	    		//$('<input type="text" id="price" style="width: 50%">');
	    	td.append(dirctBuilder);
	    	tr.append(td);
	    	$("#acctItemTypes").append(tr);
			$scope.queryAcctItemTypeUps(randStr);
			
	    }
	    
	    //查询费用大类
		$scope.queryAcctItemTypeUps=function(number){
			costSettingService.queryAcctItemType({"inParma":JSON.stringify({"qryType":"top"})},
				function(data){
					data=eval("("+data+")");
					if(data.result=="false"){
						$scope.isSuccess=false;
						return false;
					}
					var acctItemTypeAll="acctItemTypeUps"+number;
					$scope[acctItemTypeAll]=data.data;
				},
				function(){
					$scope.isSuccess=false;
				}
				
			);
		}
		$scope.queryAcctItemTypeUps(1);
		//查询物业细类
		$scope.queryAcctItemType=function(upAcctItemTypeId,number){
			costSettingService.queryAcctItemType({"inParma":JSON.stringify(
				{"qryType":"","parentAcctItemTypeId":upAcctItemTypeId})
				},
				function(data){
					data=eval("("+data+")");
					if(data.result=="false"){
						$scope.isSuccess=false;
						return false;
					}
					var acctItemTypeAll="acctItemTypes"+number;
					$scope[acctItemTypeAll]=data.data;
				},
				function(){
					$scope.isSuccess=false;
				}
				
			);
		}
		// 查询小区信息
		$scope.queryCommunity = function () {
			// 服务请求
			propertyService.queryCommunity({"inParma" : JSON.stringify( {
					"buildingId" : ""
				})},
				function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					$scope.communitys = data.data;
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		// 查询小区
		$scope.queryCommunity();
		
		// 查询小区楼栋信息
		$scope.queryBuilding = function (communityId) {
			// 服务请求
			propertyService.queryBuilding( {
				"inParma" : JSON.stringify( {
					"communityId" : communityId
				})
			},function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					$scope.buildings = data.data;
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		
		// 查询楼栋单元信息
		$scope.queryBuildingUnit = function (buildingId) {
			// 服务请求
			propertyService.queryBuilding( {
				"inParma" : JSON.stringify( {
					"ownerBuilding" : buildingId
				})
			},function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					$scope.buildingUnits = data.data;
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		// 查询房间信息
		$scope.roomPage = 0;
		$scope.queryRoom = function (buildingId) {
			// 服务请求
			propertyService.queryRoom( {
				"inParma" : JSON.stringify( {
					"buildingId" : buildingId
				}), "page" : ++$scope.roomPage
			},function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					if (data.data) {
						for (var i=0; i<data.data.length; i++) {
							$scope.rooms.push(data.data[i]);
						}
					}
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		$scope.changeBuildingQryRoom = function (buildingId) {
			$scope.roomPage = 0;
			$scope.rooms = [];
			$scope.queryRoom(buildingId);
		}
		$(function(){  
		  	$(window).scroll(function() {  
		      //当内容滚动到底部时加载新的内容  
		      if ($(this).scrollTop() + $(window).height() + 20 >= $(document).height() && $(this).scrollTop() > 20) {  
		          //当前要加载的页码 
		    	  if ($scope.buildingUnit && $scope.buildingUnit.buildingId) {
		    		  $scope.queryRoom($scope.buildingUnit.buildingId);
		    	  }
		      }  
		  });  
		 // 新增住户
		 $scope.addParty = function (room) {
			 $scope.partyInfo = {};
			 $scope.room = room;
			 $('#myModal').modal('show');
		}
		 $scope.onSave = function () {
			 // 保存逻辑
			 // 服务请求
			propertyService.addPartyInfos({"inParma" : JSON.stringify({
					"room" : $scope.room,
					"partyInfos" : [$scope.partyInfo]
				})},
				function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					$('#myModal').modal('hide');
					MESSAGE_DIALOG.alert("保存成功");
					setTimeout(function(){MESSAGE_DIALOG.close()},1000);
				},
				function() {
						$scope.isSuccess = false;
					}
				);
		 }
});  
} ]);
