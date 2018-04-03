package com.zhu.esys.controller;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.zhu.esys.dto.LendRcordDto;
import com.zhu.esys.entity.LendRcord;
import com.zhu.esys.service.LendRecordService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="/sys/lendrecord/")
@SessionAttributes(names=ESysConstant.SESSION_USER)
public class LendRecordController {
	private final static Logger LOG = LogManager.getLogger(LendRecordController.class);
	
	@Resource
	private LendRecordService service;
	
	@RequestMapping(value="/list")
	public GridEuiVo<LendRcordDto> findAll(String searchContent,Long page, Long rows, Map<String, Object> map) {
		List<LendRcordDto> dtos = service.findAll(searchContent,(page-1)*rows, rows, map);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
}
