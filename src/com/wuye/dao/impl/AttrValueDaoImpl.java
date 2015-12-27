package com.wuye.dao.impl;

import org.springframework.stereotype.Repository;

import com.wuye.common.dao.hibernate.BaseDaoHibernate;
import com.wuye.dao.AttrValueDao;
import com.wuye.entity.AttrValue;

@Repository(value="attrValueDao")
public class AttrValueDaoImpl extends BaseDaoHibernate implements AttrValueDao {
	
}
