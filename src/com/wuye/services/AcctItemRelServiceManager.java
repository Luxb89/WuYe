package com.wuye.services;

import java.util.Map;

import com.wuye.common.services.BaseManager;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;

public interface AcctItemRelServiceManager extends BaseManager {

	RetVO getAcctItemType(Map<String, Object> map);

	RetVO save(Map<String, Object> inMap);

	RetVO remove(Map<String, Object> inMap);

	PageInfo getBuildingByName(String inParma, boolean b, Integer valueOf, int i);

	int getBuildingCount(Map<String, Object> map);

	RetVO getSimpleBuildingBycommunity(Map<String, Object> paramMap);

}
