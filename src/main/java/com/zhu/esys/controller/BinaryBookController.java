package com.zhu.esys.controller;
import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.zhu.common.entity.WoResultCode;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.service.BinaryBookService;
import com.zhu.esys.vo.GridEuiVo;
@RestController
@RequestMapping(value="sys/binarybook/")
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
}
