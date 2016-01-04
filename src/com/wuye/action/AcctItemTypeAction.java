package com.wuye.action;

import java.util.HashMap;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.wuye.common.util.numeric.NumericUtil;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.services.AcctItemTypeServiceManager;
import com.wuye.services.AttrSpecServiceManager;


public class AcctItemTypeAction extends ActionSupport{
	private Logger log=Logger.getLogger(AcctItemTypeAction.class);
	@Autowired
	private AcctItemTypeServiceManager acctItemTypeServiceManager;
	@Autowired
	private AttrSpecServiceManager attrSpecServiceManager;
	@Setter
	@Getter
	private int page;
	@Setter
	@Getter
	private String inParma;
	@Setter
	@Getter
	private String suc_info;
	
	public String getAcctItemType(){
		Map<String,Object> retMap = new HashMap<String, Object>();
		Map<String,Object> paramMap = new HashMap<String, Object>();
		try {
			JSONObject json =JSONObject.fromObject(inParma);
			String type = StrUtil.strnull(json.get("qryType"));
			String parentAcctItemTypeId= StrUtil.strnull(json.get("parentAcctItemTypeId"));
			RetVO retvo = null;
			paramMap.put("qryType", type);
			paramMap.put("parentAcctItemTypeId", parentAcctItemTypeId);
			retvo = acctItemTypeServiceManager.getAcctItemType(paramMap);
			
			if (retvo != null && BaseConstants.RET_TRUE.equals(retvo.getResult())){
				if (retvo.getPageInfo() != null){
					retMap.put("data", retvo.getPageInfo().getDataList());
				}
				retMap.put("result", "true");
				retMap.put("msg", "费用类型信息查询成功!");
				
			}else{
				retMap.put("result", "false");
				retMap.put("msg", "费用类型信息查询失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			retMap.put("result", "false");
			retMap.put("msg", "费用类型信息查询失败!");
		}
		JSONObject jsonArr = JSONObject.fromObject(retMap);
		suc_info = jsonArr.toString();
		return SUCCESS;
	}
	/**
	 * 获取公摊算法
	 * @return
	 */
	public String getAttrValue(){
		Map<String,Object> retMap = new HashMap<String, Object>();
		Map<String,Object> paramMap = new HashMap<String, Object>();
		try {
			JSONObject json =JSONObject.fromObject(inParma);
			if (json.containsKey("qryType")){
				String qryType = json.getString("qryType");
				paramMap.put("qryType", qryType);
			}
			if(!StrUtil.isNullOrEmpty(json.get("attrId"))){
				paramMap.put("attrId", NumericUtil.nullToIntegerZero(json.get("attrId")));
			}
			if(!StrUtil.isNullOrEmpty(json.get("attrCd"))){
				paramMap.put("attrCd", StrUtil.strnull(json.get("attrCd")));
			}
			
			RetVO retvo = attrSpecServiceManager.getAttrValue(paramMap);
			if (retvo != null && BaseConstants.RET_TRUE.equals(retvo.getResult())){
				if (retvo.getObject() != null){
					JSONArray jsArray = (JSONArray)retvo.getObject();
					suc_info = jsArray.toString();
					retMap.put("data", jsArray);
				}
				retMap.put("result", "true");
				retMap.put("msg", "计算方法信息查询失败!");
				
			}else{
				retMap.put("result", "false");
				retMap.put("msg", "计算方法信息查询失败!");
			}
			
			//JsonConfig jsonConfig = new JsonConfig();
			
			
		} catch (Exception e) {
			retMap.put("result", "false");
			retMap.put("msg", "计算方法信息查询失败!");
		}
		JSONObject jsonArr = JSONObject.fromObject(retMap);
		suc_info = jsonArr.toString();
		return SUCCESS;
	}
}
