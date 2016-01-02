package com.wuye.action;

import java.util.HashMap;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.services.AcctItemTypeServiceManager;


public class AcctItemTypeAction extends ActionSupport{
	private Logger log=Logger.getLogger(AcctItemTypeAction.class);
	@Autowired
	private AcctItemTypeServiceManager acctItemTypeServiceManager;
	
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
}
