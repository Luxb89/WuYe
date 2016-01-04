package com.wuye.dao.impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wuye.common.dao.hibernate.BaseDaoHibernate;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.PageInfo;
import com.wuye.dao.AcctItemTypeDao;
@Repository(value="acctItemTypeDao")
public class AcctItemTypeDaoImpl extends BaseDaoHibernate implements AcctItemTypeDao {
	public PageInfo getAcctItemType(Map<String, Object> map) {
		if (map == null){
			return null;
		}
		StringBuffer hql = new StringBuffer();
		hql.append("from AcctItemType c where 1=1 ");
		ArrayList params=new ArrayList();
		if(map.containsKey("qryType")){
			//默认取大类，即parentAcctTypeId为空的
			if(!StrUtil.isNullOrEmpty(map.get("qryType"))
					&&"top".equals(map.get("qryType"))){
				hql.append(" and c.parentAcctTypeId='0'");
			}else{
				if(map.containsKey("parentAcctItemTypeId")
						&&!StrUtil.isNullOrEmpty(map.get("parentAcctItemTypeId"))){
					hql.append(" and c.parentAcctTypeId= ? ");
					params.add(map.get("parentAcctItemTypeId"));
				}
			}
		}
		PageInfo pageInfo = super.findPageInfoByHQLAndParams(hql.toString(), params, 0, 3000);
		return pageInfo;
	}
}
