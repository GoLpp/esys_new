package com.zhu.esys.service;

import java.util.Map;

import com.zhu.esys.dto.DiscussDto;

public interface DiscussService {

	void create(Map<String, Object> map, DiscussDto dto);

	void delete(String ids);

}
