package com.qfedu.esys.util;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.common.entity.WoResultCode;

public class ESysConstant {
	private final static Logger LOG = LogManager.getLogger(ESysConstant.class);
	
	public final static String APP_JSON = "application/json";
	
	public final static String SESSION_USER = "woUser";
	
	public final static WoResultCode ERR_LOGIN = new WoResultCode (102, "用户名或者密码不正确！");
	
	public final static WoResultCode ERR_LOGIN2 = new WoResultCode (103, "用户名或者密码不正确！");
}
