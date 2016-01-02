/**
 * 控制器
 * 
 * @author zhenggw
 */
var noticeManagerApp = angular.module("noticeManagerApp", ["commonApp", "propertyServiceApp"]);

noticeManagerApp("noticeManagerController", [ "$scope", "commonService",
		"propertyService", "$timeout", "$log",
		function($scope, commonService, propertyService, $timeout, $log) {
	
		//加载出错，弹出提示框
	    $scope.isSuccess = true;
	    $scope.$watch('isSuccess',function(nv,ov){
			if(!nv){
				$scope.isSuccess = true;
			    MESSAGE_DIALOG.error("出错了！");
			    setTimeout(function(){MESSAGE_DIALOG.close()},2000);
			}
	    });
		    
} ]);
