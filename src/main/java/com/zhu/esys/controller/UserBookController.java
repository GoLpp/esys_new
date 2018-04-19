package com.zhu.esys.controller;
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.zhu.common.entity.WoResultCode;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.dto.UserBookDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.service.UserBookService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="sys/userbook/")
@SessionAttributes(names={ESysConstant.SESSION_USER})
public class UserBookController {
	private final static Logger LOG = LogManager.getLogger(UserBookController.class);
	
	@Resource
	private UserBookService userBookService;
	
	@RequestMapping(value="/create")
	public WoResultCode create(UserBookDto bookDto, MultipartFile bookFile, Map<String, Object> map) {
		try{
			if(bookFile != null) {
				String realPath = "userbooks/" + bookFile.getOriginalFilename();
				String obsolutPath = WoUtil.getWoot() + "/" + realPath;
				bookFile.transferTo(new File(obsolutPath));
				bookDto.setUrl(realPath);
			}
		}catch (Exception e) {
			return new WoResultCode(132, "上传失败");
		}
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		userBookService.create(bookDto, userDto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/update")
	public WoResultCode update(UserBookDto bookDto, MultipartFile bookFile, Map<String, Object> map) {
		try{
			if(bookFile != null) {
				String realPath = "userbooks/" + bookFile.getOriginalFilename();
				String obsolutPath = WoUtil.getWoot() + "/" + realPath;
				bookFile.transferTo(new File(obsolutPath));
				bookDto.setUrl(realPath);
			}
		}catch (Exception e) {
			return new WoResultCode(132, "上传失败");
		}
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		userBookService.update(bookDto, userDto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(String bookIds) {
		userBookService.delete(bookIds);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/list")
	public GridEuiVo<UserBookDto> getList(Map<String, Object> map, Long page, Long rows, String searchContent) {
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		List<UserBookDto> dtos = userBookService.getList(userDto, (page-1)*rows, rows, searchContent);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/listAll")
	public GridEuiVo<UserBookDto> getAll(Long page, Long rows, String searchContent) {
		List<UserBookDto> dtos = userBookService.getAll((page-1)*rows, rows, searchContent);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/tjbook")
	public WoResultCode tjBook(String bookIds) {
		userBookService.tjBook(bookIds);
		return WoResultCode.getSuccessCode();
	}
}
