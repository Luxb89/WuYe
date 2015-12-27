package com.wuye.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.wuye.common.dao.hibernate.BaseDaoHibernate;
import com.wuye.dao.UserAuthDao;
import com.wuye.entity.UserAuth;

@Repository("userAuthDao")
public class UserAuthDaoImpl extends BaseDaoHibernate implements UserAuthDao{

	public void saveUserAuth(UserAuth userAuth) {
		this.addObject(userAuth);
	}

	public void removeUserAuthByRoleId(int roleId) {
		String hql = " delete from user_auth  where role_id = ? ";
		List params = new ArrayList();
		params.add(roleId);
		this.executeSql(hql, params);
	}

}
