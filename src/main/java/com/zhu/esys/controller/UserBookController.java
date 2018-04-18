package com.zhu.esys.controller;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.UserBookDto;
import com.zhu.esys.util.ESysConstant;
@RestController
@RequestMapping(value="sys/userbook/")
@SessionAttributes(names={ESysConstant.SESSION_USER})
public class UserBookController {
	private final static Logger LOG = LogManager.getLogger(UserBookController.class);
	
	@RequestMapping(value="/create")
	public WoResultCode create(UserBookDto dto, MultipartFile bookFile) {
		return WoResultCode.getSuccessCode();
	}
}
