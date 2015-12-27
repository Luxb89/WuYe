package com.wuye.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuye.common.services.impl.BaseManagerImpl;
import com.wuye.dao.AreaDao;
import com.wuye.entity.Area;
import com.wuye.services.AreaServiceManager;

@Service("areaServiceManager")
public class AreaServiceManagerImpl extends BaseManagerImpl implements AreaServiceManager{
	
	@Autowired
	private AreaDao areaDao;
	
	public List<Area> getAreas(int upAreaId) {

		return areaDao.getAreas(upAreaId);
	}

}
