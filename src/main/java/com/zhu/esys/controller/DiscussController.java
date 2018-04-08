package com.zhu.esys.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.DiscussDto;
import com.zhu.esys.service.DiscussService;
import com.zhu.esys.util.ESysConstant;

@RestController
@RequestMapping(value="/sys/discuss/")
@SessionAttributes(names={ESysConstant.SESSION_USER})
public class DiscussController {
	@Resource
	private DiscussService service;
	
	@RequestMapping(value="/create")
	public WoResultCode create(Map<String, Object> map, DiscussDto dto) {
		service.create(map,dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(String ids) {
		service.delete(ids);
		return WoResultCode.getSuccessCode();
	}
}
