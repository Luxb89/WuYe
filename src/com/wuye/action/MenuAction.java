package com.wuye.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.wuye.common.util.string.StrUtil;
import com.wuye.common.vo.MenuVo;
import com.wuye.common.vo.RetVO;
import com.wuye.constants.BaseConstants;
import com.wuye.entity.Role;
import com.wuye.entity.User;
import com.wuye.services.LoginService;
import com.wuye.services.LoginServiceManager;
import com.wuye.services.PrivilegeServiceManager;
import com.wuye.services.RoleServiceManager;

public class MenuAction extends ActionSupport{
    
    @Autowired
    private PrivilegeServiceManager privilegeServiceManager;
	
    @Setter
    @Getter
    private String jsondata;
    
    @Setter
    @Getter
    private String suc_info = "";
	
	public String loadMenu() {
	    Map<String,Object> map = new HashMap<String, Object>();
        Map<String,Object> inMap = new HashMap<String, Object>();
        ActionContext ctx = ActionContext.getContext();
        Object obj = ctx.getSession().get("user");
        User user = null;
        if (obj != null) {
            user = (User)obj;
        }
        try {
            if (jsondata != null) {
                inMap.put("privilegeType", jsondata);
            }
            if (user != null) {
                inMap.put("userId", user.getId());
            }
            inMap.put("isParent", "0");
            List<MenuVo> menuList = privilegeServiceManager.qryUserMenuPrivilege(inMap);
            if (menuList != null && menuList.size() >0){
                map.put("menu", menuList);
                map.put("result", "true");
                map.put("msg", "权限获取成功！");
            }else {
                map.put("result", "false");
                map.put("msg", "权限获取失败！");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", "false");
            map.put("msg", "权限获取失败！");
        }
        JSONObject jsontip = JSONObject.fromObject(map);
        suc_info = jsontip.toString();
	    return SUCCESS;
	}
	
}
