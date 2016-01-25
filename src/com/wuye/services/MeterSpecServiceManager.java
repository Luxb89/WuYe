package com.wuye.services;

import java.util.Map;

import net.sf.json.JSONObject;

import com.wuye.common.services.BaseManager;
import com.wuye.common.vo.PageInfo;
import com.wuye.common.vo.RetVO;

public interface MeterSpecServiceManager extends BaseManager {

	RetVO getAcctItemType(Map<String, Object> map);

	RetVO save(JSONObject json);

	RetVO remove(JSONObject json);

	RetVO queryMeterSpecs(JSONObject json);

}
