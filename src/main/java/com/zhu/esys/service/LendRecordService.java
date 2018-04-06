package com.zhu.esys.service;

import java.util.List;
import java.util.Map;

import com.zhu.esys.dto.LendRcordDto;

public interface LendRecordService {

	List<LendRcordDto> findAll(String searchContent, Long l, Long rows, Map<String, Object> map);

	List<LendRcordDto> findReturn(Long page, Long rows, Map<String, Object> map);

	List<LendRcordDto> findNoReturn(Long page, Long rows, Map<String, Object> map);
	
}
