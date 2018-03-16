package com.zhu.esys.controller;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zhu.common.entity.WoPage;
import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.RoleDto;
import com.zhu.esys.service.RoleService;
import com.zhu.esys.vo.GridEuiVo;
import com.zhu.esys.util.ESysConstant;


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
