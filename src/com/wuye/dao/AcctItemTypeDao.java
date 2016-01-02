package com.wuye.dao;

import java.util.List;
import java.util.Map;

import com.wuye.common.dao.Dao;
import com.wuye.common.vo.PageInfo;
import com.wuye.entity.Building;

public interface AcctItemTypeDao extends Dao {
	public PageInfo getAcctItemType(Map<String, Object> map);
}
