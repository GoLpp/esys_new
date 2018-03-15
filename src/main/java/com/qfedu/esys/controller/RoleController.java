package com.qfedu.esys.controller;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.qfedu.common.entity.WoPage;
import com.qfedu.common.entity.WoResultCode;
import com.qfedu.esys.dto.RoleDto;
import com.qfedu.esys.service.RoleService;
import com.qfedu.esys.util.ESysConstant;
import com.qfedu.esys.vo.GridEuiVo;

@RestController
@RequestMapping(value="/sys/role", produces=ESysConstant.APP_JSON)
public class RoleController {
	private final static Logger LOG = LogManager.getLogger(RoleController.class);
	
	@Resource
	private RoleService roleService;  
	
	@RequestMapping(value="/list")
	public GridEuiVo<RoleDto> getGridData(String name, Long page, Long rows) {
		WoPage<RoleDto> grid = roleService.getGridData(name, (page - 1) * rows, rows);
		return new GridEuiVo<>(grid);
	}
	
	@RequestMapping(value="/create")
	public WoResultCode create(RoleDto dto) {
		roleService.create(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/update")
	public WoResultCode update(RoleDto dto) {
		roleService.update(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(String woSelectedIds) {
		roleService.delete(woSelectedIds);
		return WoResultCode.getSuccessCode();
	}
}
