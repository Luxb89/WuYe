package com.wuye.dao;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.wuye.common.dao.Dao;
import com.wuye.common.util.bean.EntityCopyUtil;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.entity.Address;
import com.wuye.entity.Area;
import com.wuye.entity.Community;
import com.wuye.entity.Organization;
import com.wuye.entity.PartyInfo;
import com.wuye.entity.Privilege;
import com.wuye.entity.PropertyCompany;

public interface PrivilegeDao extends Dao{
	/**
	 * 获取权限列表
	 * @param map
	 * @return
	 */
	List<Privilege> getPrivilegeList(Map<String, Object> map);
	
	/**
	 * 根据roleId获取其下的权限信息
	 * @param roleId
	 * @return
	 */
	List<Privilege> getPrivilegeListByRoleId(int roleId);
	/**
	 * 
	 * .
	 * 
	 * @param map
	 * @param fuzzy
	 * @param currentPage
	 * @param perPageNum
	 * @return
	 * @author Luxb
	 * 2015-12-16 Luxb
	 */
	PageInfo qryPrivilegeList(Map<String,Object> map, boolean fuzzy,final int currentPage, final int perPageNum);
	/**
	 * 
	 * .
	 * 
	 * @param srcPrivilege
	 * @return
	 * @author Luxb
	 * 2015-12-14 Luxb
	 */
	void add(JSONObject srcPrivilege) throws Exception;
	/**
	 * 
	 * .
	 * 
	 * @param srcPrivilege
	 * @return
	 * @author Luxb
	 * 2015-12-14 Luxb
	 */
    void update(JSONObject srcPrivilege) throws Exception;
    /**
     * 
     * .
     * 
     * @return
     * @author Luxb
     * 2015-12-14 Luxb
     */
    List<Privilege> getParentPrivilege(Map<String, Object> map);
}
