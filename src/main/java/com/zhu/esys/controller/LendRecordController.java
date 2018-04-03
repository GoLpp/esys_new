package com.zhu.esys.controller;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.zhu.esys.entity.LendRcord;
import com.zhu.esys.entity.LendRcordDto;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="/sys/lendrecord/")
@SessionAttributes(names=ESysConstant.SESSION_USER)
public class LendRecordController {
	private final static Logger LOG = LogManager.getLogger(LendRecordController.class);
	
	@RequestMapping(value="/list")
	public GridEuiVo<LendRcordDto> findAll() {
		return null;
	}
}
