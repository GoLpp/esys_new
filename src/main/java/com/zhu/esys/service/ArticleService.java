package com.zhu.esys.service;

import java.util.List;
import java.util.Map;

import com.zhu.esys.dto.ArticleDto;
import com.zhu.esys.dto.UserDto;

public interface ArticleService {

	void create(ArticleDto articleDto, UserDto userDto);

	void update(ArticleDto dto);

	void delete(String ids);

	List<ArticleDto> findAll(String searchContent, Long page, Long rows, Map<String, Object> map);

	List<ArticleDto> findTj(Long page, Long rows);

}
