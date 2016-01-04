package com.wuye.services;

import java.util.Map;

import com.wuye.common.services.BaseManager;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;

public interface AcctItemTypeServiceManager extends BaseManager {

	RetVO getAcctItemType(Map<String, Object> map);
}
