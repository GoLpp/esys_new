package com.zhu.esys.service;

import java.util.List;
import java.util.Map;

import com.zhu.esys.dto.BookDiscussDto;
import com.zhu.esys.dto.DiscussDto;
import com.zhu.esys.dto.UserDto;

public interface DiscussService {

	void create(Map<String, Object> map, DiscussDto dto);

	void delete(String ids);

	List<DiscussDto> getList(UserDto userDto, Long page, Long rows);

	void createBookDiscuss(UserDto userDto, BookDiscussDto dto);

}
