package com.wuye.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.wuye.common.json.HibernatePropertyFilter;
import com.wuye.common.json.InvisibleFilter;
import com.wuye.common.util.SpringUtil;
import com.wuye.common.util.date.DateUtil;
import com.wuye.common.util.date.JsonDateValueProcessor;
import com.wuye.common.util.json.JSONUtils;
import com.wuye.common.util.numeric.NumericUtil;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.entity.Address;
import com.wuye.entity.Area;
import com.wuye.entity.Community;
import com.wuye.entity.Organization;
import com.wuye.entity.PartyInfo;
import com.wuye.entity.PropertyCompany;
import com.wuye.services.AttrSpecServiceManager;
import com.wuye.services.AcctItemRelServiceManager;
import com.wuye.services.CommunityServiceManager;

public class AcctItemRelAction extends ActionSupport{
	private Logger log=Logger.getLogger(AcctItemRelAction.class);
	@Autowired
	private AcctItemRelServiceManager acctItemRelServiceManager;
	
	@Setter
	@Getter
	private int page;
	@Setter
	@Getter
	private String inParma;
	@Setter
	@Getter
	private String suc_info;
	
	public String saveAcctItemRel(){
		
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> inMap = new HashMap<String, Object>();
		try {
			JSONObject json =JSONObject.fromObject(inParma);
			if(!StrUtil.isNullOrEmpty(json)){
				RetVO retVo = acctItemRelServiceManager.save(json);
				if (BaseConstants.RET_TRUE.equals(retVo.getResult())){
					map.put("result", "true");
					map.put("msg", "保存信息成功");
				}else {
					map.put("result", "false");
					map.put("msg", "保存信息失败:"+retVo.getRetMsg());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "false");
			map.put("msg", "保存费用信息失败");
			log.info(e.getMessage());
		}
		JSONObject jsontip = JSONObject.fromObject(map);
		suc_info = jsontip.toString();
		return SUCCESS;
	}
	
	public String removeAcctItemRel(){
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> inMap = new HashMap<String, Object>();
		try {
			JSONObject json = JSONObject.fromObject(inParma);
			if(json.size()>0){
				RetVO retVo = acctItemRelServiceManager.remove(json);
				if (BaseConstants.RET_TRUE.equals(retVo.getResult())){
					map.put("result", "true");
					map.put("msg", "删除成功");
				}else {
					map.put("result", "false");
					map.put("msg", "删除失败");
				}
			}else{
				map.put("result", "false");
				map.put("msg", "删除的信息不能为空");
			}
			
		} catch (Exception e) {
			map.put("result", "false");
			map.put("msg", "删除失败");
			e.printStackTrace();
			log.info(e.getMessage());
		}
		JSONObject jsontip = JSONObject.fromObject(map);
		suc_info = jsontip.toString();
		return SUCCESS;
	}
	/**
	 * 获取配置的费用信息
	 * @return
	 */
	public String queryAcctItemRels(){
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> inMap = new HashMap<String, Object>();
		try {
			JSONObject json =JSONObject.fromObject(inParma);
			if(json.size()>0){
				RetVO retVo = acctItemRelServiceManager.queryAcctItemRels(json);
				if (BaseConstants.RET_TRUE.equals(retVo.getResult())){
					map.put("result", "true");
					map.put("data", retVo.getDataList());
					map.put("msg", "查询成功");
				}else {
					map.put("result", "false");
					map.put("msg", "查询失败");
				}
			}
			
		} catch (Exception e) {
			map.put("result", "false");
			map.put("msg", "查询失败");
			e.printStackTrace();
			log.info(e.getMessage());
		}
		JSONObject jsontip = JSONObject.fromObject(map);
		suc_info = jsontip.toString();
		return SUCCESS;
	}
}
