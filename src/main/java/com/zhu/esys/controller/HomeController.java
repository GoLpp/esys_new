package com.zhu.esys.controller;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.ESysException;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.service.UserService;
import com.zhu.esys.util.ESysConstant;


@Controller
@RequestMapping("/")
public class HomeController {
	private final static Logger LOG = LogManager.getLogger(HomeController.class);
	
	/**
	 * @return
	 */
	@RequestMapping ("/")
	public ModelAndView toHome (HttpServletRequest req) {
		String msg = "欢迎您！";
		Boolean woLogin = false;
		// 从session获取用户信息，从而判断是否登录
		UserDto u = (UserDto)req.getSession().getAttribute(ESysConstant.SESSION_USER);
		if (u != null) {
			msg = u.getLoginName() + "," + msg;
			woLogin = true;
		}
		ModelAndView m = new ModelAndView ();
		m.addObject("woWelcomeMsg", msg);
		m.addObject("woLogin", woLogin);
		m.setViewName("main");
		return m;
	}
	
	@Resource
	private UserService userService;
	
	@ResponseBody
	@RequestMapping (value="/authentication", produces = ESysConstant.APP_JSON)
	public WoResultCode login (String user, String password, String num, HttpServletRequest req) {
		String aString = (String) req.getSession().getAttribute("code");
		if(num==null || !num.equalsIgnoreCase(aString)) {
			return new WoResultCode(0, "验证码输入错误");
		}
		try {
			UserDto u = userService.authenticate (user, password);
			req.getSession().setAttribute(ESysConstant.SESSION_USER, u);
			return WoResultCode.getSuccessCode();
		} catch (ESysException e) {
			return e.getCode();
		}
	}
	
	@ResponseBody
	@RequestMapping (value="/logout", produces = ESysConstant.APP_JSON)
	public WoResultCode logout (HttpServletRequest req) {
		req.getSession().removeAttribute(ESysConstant.SESSION_USER);
		return WoResultCode.getSuccessCode();
	}
}