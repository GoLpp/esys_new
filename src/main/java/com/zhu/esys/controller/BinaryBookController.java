package com.zhu.esys.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.zhu.common.entity.WoResultCode;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.ESysException;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.dto.UserDto;
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
				LOG.info("upBook=========" + obsolutePath);
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
	
	@Resource
	@Qualifier("binaryBookView")
	private View binaryBookView;
	
	@RequestMapping(value="/importDown")
	public ModelAndView modelDown() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setView(binaryBookView);
		return modelAndView;
	}
	
	@RequestMapping(value="/importExcel")
	public WoResultCode importExcel(MultipartFile excelFile) {
		try(InputStream in = excelFile.getInputStream()) {
			String fileName = excelFile.getName();
			bookService.importExcel(in, fileName);
		}catch (Exception e) {
			return new WoResultCode(118, "文件失效");
		}
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/tjlist")
	public GridEuiVo<BinaryBookDto> tjBook(Long page, Long rows) {
		List<BinaryBookDto> dtos = bookService.tjBook((page-1)*rows, rows);
		return new GridEuiVo<>(Long.valueOf(dtos.size()), dtos);
	}
	
	@RequestMapping(value="/return")
	public WoResultCode returnBook(String bookIds, Map<String, Object> map) {
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		bookService.returnBook(bookIds, userDto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping(value="/down")
	public WoResultCode downBook(String url, HttpServletResponse resp) {
		String downFile = WoUtil.getWoot() + "/" + url;
		LOG.info("============" + downFile);
		String fileName = WoUtil.parseGBK(url.substring(url.indexOf("/") + 1));
		resp.setHeader("content-disposition","attachment;filename=" + fileName);
		InputStream inputStream = null;
		OutputStream out = null;
		try {
			inputStream = new FileInputStream(new File(downFile));
			out = resp.getOutputStream();
			byte[] buf = new byte[1024];
			int length = 0;
			while((length=inputStream.read(buf)) != -1) {
				out.write(buf, 0, length);
			}
			out.flush();
		} catch (Exception e) {
			return new WoResultCode(001, "文件损坏");
		}finally{
			try {
				if(out != null) {
					out.close();
				}
				if(inputStream != null) {
					inputStream.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return WoResultCode.getSuccessCode();
	}
}
