package com.wuye.dao;

import java.util.List;
import java.util.Map;

import com.wuye.common.dao.Dao;
import com.wuye.entity.AttrSpec;
import com.wuye.entity.AttrValue;

public interface AttrSpecDao extends Dao {
	public List<AttrSpec> getAttr(String attrCd);
	public List<AttrSpec> getAttr(Map<String,Object> map);
	public List<AttrValue> getAttrValue(Map<String,Object> map);
	public List<AttrValue> getSysAttrValue(Map<String,Object> map);
}
