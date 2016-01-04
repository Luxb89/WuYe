/**
 * 费用服务
 * 
 * @author tanyw
 */

// 创建物业服务模块
var costSettingServiceApp = angular.module("costSettingServiceApp", [ "commonApp" ]);

costSettingServiceApp.service("costSettingService", [ "commonService", function(commonService) {
    // 获取费用大类信息
    this.queryAcctItemType = function(params, sback, eback) {
        commonService.call("acctItemTypeAction!getAcctItemType.action", params, sback, eback);
    };
} ]);