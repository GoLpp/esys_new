package com.zhu.esys.controller;
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.zhu.common.entity.WoResultCode;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.ESysException;
import com.zhu.esys.dto.ArticleDto;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.service.BinaryBookService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="sys/binarybook/")
@SessionAttributes(names=ESysConstant.SESSION_USER)
public class BinaryBookController {
	private final static Logger LOG = LogManager.getLogger(BinaryBookController.class);
	
	@Resource
	private BinaryBookService bookService;
	
	@RequestMapping(value="/create")
	public WoResultCode create(BinaryBookDto dto, MultipartFile upBook) {
		try{
			if(upBook != null) {
				String realtivePath = "books/" + upBook.getOriginalFilename();
				String obsolutePath = WoUtil.getWoot() + "/" + realtivePath;
				upBook.transferTo(new File(obsolutePath));
				dto.setUrl(realtivePath);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		bookService.create(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/list")
	public GridEuiVo<BinaryBookDto> list(String searchContent, Integer page, Integer rows) {
		List<BinaryBookDto> dtos = bookService.findAll(searchContent, (page-1)*rows, rows);
		GridEuiVo<BinaryBookDto> vo = new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
		return vo;
	}
	
	@RequestMapping(value="/update")
	public WoResultCode update(BinaryBookDto dto) {
		bookService.update(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/delete")
	public WoResultCode delete(BinaryBookDto dto) {
		bookService.delete(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/lendbook")
	public WoResultCode lendBook(BinaryBookDto dto, Map<String, Object> map) {
		try{
			bookService.lendBook(dto, map);
		}catch (ESysException e) {
			return e.getCode();
		}
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/importDown")
	public WoResultCode modelDown() {
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/tjlist")
	public GridEuiVo<BinaryBookDto> tjBook(Long page, Long rows) {
		List<BinaryBookDto> dtos = bookService.tjBook((page-1)*rows, rows);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
}
