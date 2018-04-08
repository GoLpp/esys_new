package com.zhu.esys.controller;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.ArticleDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.service.ArticleService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="sys/article/")
@SessionAttributes(names={ESysConstant.SESSION_USER})
public class ArticleController {
	private final static Logger LOG = LogManager.getLogger(ArticleController.class);
	
	@Resource
	private ArticleService service;
	
	@RequestMapping(value="/list")
	public GridEuiVo<ArticleDto> findAll(String searchContent, Long page, Long rows, Map<String, Object> map) {
		List<ArticleDto> articleDtos = service.findAll(searchContent, (page-1)*rows, rows, map);
		return new GridEuiVo<>(Long.valueOf(articleDtos.size()), articleDtos);
	}
	
	@RequestMapping(value="/save")
	public WoResultCode create(ArticleDto articleDto, Map<String, Object> map) {
		UserDto userDto  = (UserDto) map.get(ESysConstant.SESSION_USER);
		service.create(articleDto,userDto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/update")
	public WoResultCode update(ArticleDto dto) {
		service.update(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(String articleIds) {
		service.delete(articleIds);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/tjlist")
	public GridEuiVo<ArticleDto> tjList(Long page, Long rows) {
		List<ArticleDto> articleDtos = service.findTj((page-1)*rows, rows);
		return new GridEuiVo<>(Long.valueOf(articleDtos.size()), articleDtos);
	}
}
