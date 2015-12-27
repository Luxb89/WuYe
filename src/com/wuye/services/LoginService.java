package com.wuye.services;

import java.util.List;
import java.util.Map;

import com.wuye.common.services.BaseManager;
import com.wuye.entity.Privilege;
import com.wuye.entity.User;

public interface LoginService extends BaseManager{
	boolean login(String username,String password) throws Exception;
	
	List<Privilege> queryMenuPrivileges(User user, String privilege_type);
	
	Privilege getPrivilege(int privilege_id);
	
	List<Privilege> queryChildPrivileges(int privilege_id);
}
