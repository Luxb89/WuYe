package com.wuye.dao;

import java.util.List;
import java.util.Map;

import com.wuye.common.dao.Dao;
import com.wuye.common.vo.PageInfo;
import com.wuye.entity.Building;

public interface AcctItemRelDao extends Dao {
	public Building getOwnerBuildingEntt(Building building);
	public PageInfo getAcctItemType(Map<String, Object> map);
	
	public List<Building> getUnits(Building ownerBuilding);
	public PageInfo queryAcctItemRels(Map<String, Object> map);
}
