package com.wuye.services;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.wuye.common.services.BaseManager;
import com.wuye.common.vo.RetVO;

public interface NoticeServiceManager extends BaseManager {
    
    public void saveNotice(JSONObject notice, JSONArray entts, String classCode, String statusCd, String communityId);
    
    public RetVO queryNotice(String communityId, String noticeType, Integer pageNum, Integer pageSize);
}
