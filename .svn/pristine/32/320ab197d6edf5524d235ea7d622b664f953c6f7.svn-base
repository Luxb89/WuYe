package com.wuye.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.hibernate3.HibernateOperations;

import com.wuye.entity.Privilege;
import com.wuye.entity.User;



public interface LoginDao {
	boolean login(String username,String password) throws Exception;
	
	List<Privilege> queryMenuPrivileges(User user, String privilege_type);
	
	Privilege getPrivilege(int privilege_id);
	
	List<Privilege> queryChildPrivileges(int privilege_id);
}
