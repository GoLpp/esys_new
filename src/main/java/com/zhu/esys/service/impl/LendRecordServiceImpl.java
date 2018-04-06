package com.zhu.esys.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhu.common.entity.WoPage;
import com.zhu.esys.dao.LendRecordDao;
import com.zhu.esys.dto.LendRcordDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.LendRcord;
import com.zhu.esys.service.LendRecordService;
import com.zhu.esys.util.ESysConstant;
@Service
@Transactional
public class LendRecordServiceImpl implements LendRecordService{
	private final static Logger LOG = LogManager.getLogger(LendRecordServiceImpl.class);
	
	@Resource
	private LendRecordDao recordDao;
	
	@Override
	public List<LendRcordDto> findAll(String searchContent,Long page, Long rows, Map<String, Object> map) {
		UserDto userDto = (UserDto)map.get(ESysConstant.SESSION_USER);
		String whereOrderBy = "";
		Map<String, Object> props = new HashMap<>();
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + "where e.user.id = :userId";
			props.put("userId", userDto.getId());
		}
		WoPage<LendRcord> records = recordDao.findAllBy(whereOrderBy, page, rows, props);
		LendRcordDto dto = new LendRcordDto();
		return dto.gotDtos(records.getRows());
	}

	@Override
	public List<LendRcordDto> findReturn(Long page, Long rows, Map<String, Object> map) {
		UserDto userDto = (UserDto)map.get(ESysConstant.SESSION_USER);
		String whereOrderBy = "";
		Map<String, Object> props = new HashMap<>();
		whereOrderBy = whereOrderBy + "where e.statu = :statu";
		props.put("statu", "1");
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + " and e.user.id = :userId";
			props.put("userId", userDto.getId());
		}
		WoPage<LendRcord> records = recordDao.findAllBy(whereOrderBy, page, rows, props);
		LendRcordDto dto = new LendRcordDto();
		return dto.gotDtos(records.getRows());
	}

	@Override
	public List<LendRcordDto> findNoReturn(Long page, Long rows, Map<String, Object> map) {
		UserDto userDto = (UserDto)map.get(ESysConstant.SESSION_USER);
		String whereOrderBy = "";
		Map<String, Object> props = new HashMap<>();
		whereOrderBy = whereOrderBy + "where e.statu = :statu";
		props.put("statu", "0");
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + " and e.user.id = :userId";
			props.put("userId", userDto.getId());
		}
		WoPage<LendRcord> records = recordDao.findAllBy(whereOrderBy, page, rows, props);
		LendRcordDto dto = new LendRcordDto();
		return dto.gotDtos(records.getRows());
	}
	
	
}
