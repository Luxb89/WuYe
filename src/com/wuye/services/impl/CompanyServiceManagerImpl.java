package com.wuye.services.impl;

import org.springframework.stereotype.Service;

import com.wuye.common.services.impl.BaseManagerImpl;
import com.wuye.entity.PropertyCompany;
import com.wuye.services.CompanyServiceManager;

@Service("companyServiceManager")
public class CompanyServiceManagerImpl extends BaseManagerImpl implements CompanyServiceManager {

	public void save(PropertyCompany propertyCompany) {
		propertyCompany.save();
	}
	
}
