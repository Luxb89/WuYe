package com.wuye.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuye.common.services.impl.BaseManagerImpl;
import com.wuye.dao.UserAuthDao;
import com.wuye.entity.UserAuth;
import com.wuye.services.UserAuthServiceManager;

@Service("userAuthServiceManager")
public class UserAuthServiceManagerImpl extends BaseManagerImpl implements UserAuthServiceManager {

	@Autowired
	private UserAuthDao userAuthDao;
	
	public void saveUserAuth(UserAuth userAuth) {
		userAuthDao.saveUserAuth(userAuth);
	}

}
