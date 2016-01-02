package com.wuye.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wuye.common.dao.hibernate.BaseDaoHibernate;
import com.wuye.common.util.numeric.NumericUtil;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.dao.AcctItemRelDao;
import com.wuye.entity.Building;
import com.wuye.entity.Community;
@Repository(value="acctItemRelDao")
public class AcctItemRelDaoImpl extends BaseDaoHibernate implements AcctItemRelDao {
	public PageInfo getAcctItemType(Map<String, Object> map) {
		if (map == null){
			return null;
		}
		StringBuffer hql = new StringBuffer();
		hql.append("from acctItemType c where 1=1 ");
		ArrayList params=new ArrayList();
		if(map.containsKey("qryType")){
			//默认取大类，即parentAcctTypeId为空的
			if(StrUtil.isNullOrEmpty(map.get("qryType"))){
				hql.append(" and c.parentAcctTypeId is null");
			}else{
				if(map.containsKey("parentAcctItemTypeId")
						&&!StrUtil.isNullOrEmpty(map.get("childAcctItemType"))){
					hql.append(" and c.parentAcctTypeId= ? ");
					params.add(map.get("parentAcctItemTypeId"));
				}
			}
		}
		PageInfo pageInfo = super.findPageInfoByHQLAndParams(hql.toString(), params, 0, 3000);
		return pageInfo;
	}

	public Building getOwnerBuildingEntt(Building building) {
		if (building.getOwnerBuilding() == null || building.getOwnerBuilding() == 0){
			return null;
		}
		return (Building)super.getObject(Building.class, building.getOwnerBuilding());
	}

	public List<Building> getUnits(Building ownerBuilding) {
		if (ownerBuilding == null){
			return null;
		}
		String hql = " from Building b where b.ownerBuilding = ? ";
		List<Object> params = new ArrayList<Object>();
		params.add(ownerBuilding.getId());
		return super.findListByHQLAndParams(hql, params);
	}

	public PageInfo getSimpleBuildingBycommunity(Map<String, Object> map) {
		if (map == null){
			return null;
		}
		StringBuffer hql = new StringBuffer();
		hql.append("select c from Building c,Community cm where 1=1 and c.ownerBuilding is null and c.community = cm and cm.communityId= ?  and c.statusCd = ? ");
		/*Community community = (Community) Community.getDao().getObject(Community.class, NumericUtil.nullToIntegerZero(map.get("communityId")));
		if (community == null){
			return null;
		}*/
		List<Object> params = new ArrayList<Object>();
		params.add(NumericUtil.nullToIntegerZero(map.get("communityId")));
		params.add(BaseConstants.STATUS_VALID);
		
		PageInfo pageInfo = super.findPageInfoByHQLAndParams(hql.toString(), params, 1, BaseConstants.QUERY_ROW_MAX);
		return pageInfo;
	}
}
