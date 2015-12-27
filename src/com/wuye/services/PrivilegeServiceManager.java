package com.wuye.services;

import java.util.List;
import java.util.Map;

import com.wuye.common.services.BaseManager;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;
import com.wuye.entity.Privilege;

public interface PrivilegeServiceManager extends BaseManager{
    PageInfo qryPrivilegeList(Map<String,Object> map, boolean fuzzy,final int currentPage, final int perPageNum);
    RetVO save(Map<String, Object> map) throws Exception;
    RetVO del(Map<String, Object> map) throws Exception;
    RetVO getParentPrivilege(Map<String, Object> map);
    List<Privilege> qryRolePrivilegeByRoleId(int roleId);
}
