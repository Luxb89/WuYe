package com.wuye.services.impl;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuye.common.services.impl.BaseManagerImpl;
import com.wuye.common.util.bean.EntityCopyUtil;
import com.wuye.common.util.numeric.NumericUtil;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.dao.AcctItemRelDao;
import com.wuye.entity.Building;
import com.wuye.entity.Community;
import com.wuye.entity.PartyInfo;
import com.wuye.entity.PropertyCompany;
import com.wuye.services.AcctItemRelServiceManager;

@Service("acctItemRelServiceManager")
public class AcctItemRelServiceManagerImpl extends BaseManagerImpl implements
	AcctItemRelServiceManager {
	@Autowired
	AcctItemRelDao acctItemRelDao;
	public RetVO getAcctItemType(Map<String, Object> map) {
		RetVO retVO = RetVO.newInstance(BaseConstants.RET_TRUE, "");
		PageInfo pg = acctItemRelDao.getAcctItemType(map);
//		List<Object> dataList = pg.getDataList();
		retVO.setPageInfo(pg);
		return retVO;
	}

	public RetVO save(Map<String, Object> map) {
		RetVO retVo = RetVO.newInstance(BaseConstants.RET_TRUE, "");
		//String type = (String) map.get("type");
		JSONArray buildings = (JSONArray) map.get("building");
		if (buildings != null && buildings.size() > 0) {
			for (int i = 0; i < buildings.size(); i++) {
				JSONObject srcBuilding = buildings.getJSONObject(i);
				if (StrUtil.isNullOrEmpty(srcBuilding.get("buildingId"))) {
					// 新增
					this.add(srcBuilding);
				} else {
					// 更改
					this.update(srcBuilding);
				}
			}
		}

		return retVo;
	}

	public PageInfo getBuildingByName(String inParma, boolean b,
			Integer valueOf, int i) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getBuildingCount(Map<String, Object> map) {
		String hql = "select count(c.buildingId) from Building c ";
		int recordCount = NumericUtil.nullToZero(acctItemRelDao
				.getSingleValueByHql(hql));
		int pageCount = 0;
		if (recordCount % 12 == 0 && recordCount != 0) {
			pageCount = recordCount / 12;
		} else {
			pageCount = recordCount / 12 + 1;
		}
		return pageCount;
	}
	
	private RetVO add(JSONObject srcBuilding) {
		Building building = new Building();
		
		Community community = (Community) Community.getDao().getObject(Community.class, 
				srcBuilding.getJSONObject("community").getInt("communityId"));

		EntityCopyUtil.populate(building, srcBuilding, null);
		if (srcBuilding.has("partyInfo")){
			PartyInfo leaderInfo = new PartyInfo();
			EntityCopyUtil.populate(leaderInfo,
					srcBuilding.getJSONObject("partyInfo"), null);
			building.setPartyInfo(leaderInfo);
		}
		building.setCommunity(community);
		building.save();
		
		return null;
	}

	private RetVO update(JSONObject srcBuilding) {
		Building building = (Building)Building.getDefaultDao().getObject(Building.class, srcBuilding.getInt("buildingId"));
		
		Community community = (Community) Community.getDao().getObject(Community.class, 
				srcBuilding.getJSONObject("community").getInt("communityId"));

		EntityCopyUtil.populate(building, srcBuilding, null);
		if (srcBuilding.has("partyInfo") && !srcBuilding.getJSONObject("partyInfo").isEmpty()){
			PartyInfo leaderInfo = building.getPartyInfo();
			if (leaderInfo == null){
				leaderInfo = new PartyInfo();
			}
			EntityCopyUtil.populate(leaderInfo,
					srcBuilding.getJSONObject("partyInfo"), null);

			building.setPartyInfo(leaderInfo);
		}
		
		building.setCommunity(community);
		building.save();
		
		return null;
	}

	public RetVO remove(Map<String, Object> map) {
		RetVO retVo = RetVO.newInstance(BaseConstants.RET_TRUE, "");
		JSONArray buildings = (JSONArray) map.get("building");
		for (Object buildingId : buildings) {
			Building building = (Building) Building.getDefaultDao().getObject(
					Building.class, NumericUtil.nullToIntegerZero(buildingId));
			building.remove();
		}
		return retVo;
	}

	public RetVO getSimpleBuildingBycommunity(Map<String, Object> map) {
		RetVO retVO = RetVO.newInstance(BaseConstants.RET_TRUE, "");
		PageInfo pg = acctItemRelDao.getSimpleBuildingBycommunity(map);
		List<Object> dataList = pg.getDataList();
		JSONArray jsArray = new JSONArray();
		if (dataList != null && dataList.size() > 0){
			for (Object obj : dataList){
				Building building = (Building)obj;
				JSONObject jsObj = EntityCopyUtil.getJSONObject(building,new String[]{"buildingId","buildingName"});
				jsArray.add(jsObj);
				
			}
			retVO.setObject(jsArray);
		}
		return retVO;
	}

}
