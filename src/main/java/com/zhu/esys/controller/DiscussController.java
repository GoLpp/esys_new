package com.zhu.esys.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.BookDiscussDto;
import com.zhu.esys.dto.DiscussDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.service.DiscussService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;

@RestController
@RequestMapping(value="/sys/discuss/")
@SessionAttributes(names={ESysConstant.SESSION_USER})
public class DiscussController {
	@Resource
	private DiscussService service;
	
	@RequestMapping(value="/create")
	public WoResultCode create(Map<String, Object> map, DiscussDto dto) {
		service.create(map,dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(String ids) {
		service.delete(ids);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/list")
	public GridEuiVo<DiscussDto> getList(Map<String, Object> map, Long page, Long rows) {
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		List<DiscussDto> dtos = service.getList(userDto, (page-1)*rows, rows);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/listbyarticleid")
	public GridEuiVo<DiscussDto> getById(String articleId, Long page, Long rows) {
		List<DiscussDto> dtos = service.getById(articleId, (page-1)*rows, rows);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/createBookDiscuss")
	public WoResultCode createBookDiscuss(Map<String, Object> map, BookDiscussDto dto) {
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		service.createBookDiscuss(userDto, dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/listBookDiscuss")
	public GridEuiVo<BookDiscussDto> getBookDiscuss(String bookId) {
		List<BookDiscussDto> dtos = service.findBookDiscuss(bookId);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/listAllBookDiscuss")
	public GridEuiVo<BookDiscussDto> getAllBookDiscuss() {
		List<BookDiscussDto> dtos = service.findAllBookDiscuss();
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
}
