package com.wuye.dao;

import java.util.List;
import java.util.Map;

import com.wuye.common.dao.Dao;
import com.wuye.common.vo.PageInfo;
import com.wuye.entity.Building;

public interface BuildingDao extends Dao {
	public Building getOwnerBuildingEntt(Building building);
	public PageInfo getBuilding(Map<String, Object> map, int currentPage, int perPageNum);
	
	public List<Building> getUnits(Building ownerBuilding);
	public PageInfo getSimpleBuildingBycommunity(Map<String, Object> map);
}
