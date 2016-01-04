/**
 * 控制器
 * 
 * @author zhenggw
 */
var noticeReleaseApp = angular.module("noticeReleaseApp", ["commonApp", "propertyServiceApp", "noticeServiceApp"]);

noticeReleaseApp.controller("noticeReleaseController", [ "$scope", "commonService", "propertyService",
		"noticeService", "$timeout", "$log",
		function($scope, commonService, propertyService, noticeService, $timeout, $log) {
		$scope.isPc = isPC();
		//加载出错，弹出提示框
	    $scope.isSuccess = true;
	    $scope.$watch('isSuccess',function(nv,ov){
			if(!nv){
				$scope.isSuccess = true;
			    MESSAGE_DIALOG.error("出错了！");
			    setTimeout(function(){MESSAGE_DIALOG.close()},2000);
			}
	    });
	    // 查询小区信息
		$scope.queryCommunity = function () {
			// 服务请求
			propertyService.queryCommunity( {
					"inParma" : "{}", "page" : ++$scope.pageNum
				},
				function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					if (data.data) {
						for (var i=0; i<data.data.length; i++) {
							$scope.communitys.push(data.data[i]);
						}
					}
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		
		// 查询小区楼栋信息
		$scope.queryBuilding = function (communityId) {
			$scope.communityId = communityId;
			// 服务请求
			propertyService.queryBuilding( {
				"inParma" : JSON.stringify( {
					"communityId" : communityId
				}), "page" : ++$scope.pageNum
			},function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					if (data.data) {
						for (var i=0; i<data.data.length; i++) {
							$scope.buildings.push(data.data[i]);
						}
					}
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		
		// 查询楼栋单元信息
		$scope.queryBuildingUnit = function (buildingId) {
			$scope.buildingId = buildingId;
			// 服务请求
			propertyService.queryBuilding( {
				"inParma" : JSON.stringify( {
					"ownerBuilding" : buildingId
				}), "page" : ++$scope.pageNum
			},function(data) {
					data = eval("(" + data + ")");
					if (data.result=="false") {
						$scope.isSuccess = false;
						return false;
					}
					// 调用成功
					if (data.data) {
						for (var i=0; i<data.data.length; i++) {
							$scope.buildingUnits.push(data.data[i]);
						}
					}
					},
					function() {
						$scope.isSuccess = false;
					}
				);
			}
		// 查询房间信息
		$scope.queryRoom = function (buildingId) {
			$scope.buildingUnitId = buildingId;
			// 服务请求
			propertyService.queryRoom( {
				"inParma" : JSON.stringify( {
					"buildingId" : buildingId
				}), "page" : ++$scope.pageNum
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
		$scope.changeCommunity = function (communityId) {
			$scope.pageNum = 0;
			$scope.buildings = [];
			$scope.queryBuilding(communityId);
		}
		$scope.changeBuilding = function (buildingId) {
			$scope.pageNum = 0;
			$scope.buildingUnits = [];
			$scope.queryBuildingUnit(buildingId);
		}
		$scope.changeBuildingUnit = function (buildingId) {
			$scope.pageNum = 0;
			$scope.rooms = [];
			$scope.queryRoom(buildingId);
		}
		// 
	    $scope.choose = function (flag) {
	    	// 初始化
	    	$scope.flag = flag;
	    	$scope.pageNum = 0;
	    	$("#checkAll").attr("checked", false);
	    	$scope.communitys = [];
	    	$scope.buildings = [];
	    	$scope.buildingUnits = [];
	    	$scope.rooms = [];
	    	$scope.queryCommunity();
	    	$("#myModal").modal('show');
	    }
	    $scope.onSave = function () {
	    	var chk_value =[]; 
			$('input[name="check"]:checked').each(function(){ 
				chk_value.push($(this).val()); 
			}); 
	    }
	    $(function(){
	    	if ($scope.isPc) {
	    		$("#ui-header").addClass("hide");
	    	}
		  	$('#myModal').scroll(function() {  
		      //当内容滚动到底部时加载新的内容  
		      if ($(this).scrollTop() + $('#myModal').height() + 2 >= $('#myModal').height() && $(this).scrollTop() > 2) {  
		          //当前要加载的页码 
		    	  if ($scope.flag == 1) {
		    		  $scope.queryCommunity();
		    	  } else if ($scope.flag == 2) {
		    		  $scope.queryBuilding($scope.communityId);
		    	  } else if ($scope.flag == 3) {
		    		  $scope.queryBuilding($scope.buildingId);
		    	  } else if ($scope.flag == 4) {
		    		  $scope.queryRoom($scope.buildingUnitId);
		    	  } 
		    	}
		  })
		});  
} ]);

$('#textarea').wysihtml5();
$('#myModal').on('show.bs.modal', function (event) {
  $('#myModal').css({'overflow-y':'scroll'});
});