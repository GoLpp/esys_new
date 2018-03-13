package com.qfedu.esys.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.qfedu.common.entity.WoResultCode;
import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;
import com.qfedu.esys.service.IUserService;
import com.qfedu.esys.util.ESysConstant;
import com.qfedu.esys.vo.GridEuiVo;
import com.qfedu.esys.vo.UserEuiVo;

@Controller
@RequestMapping("/sys/user/")
public class UserController {
	private final static Logger LOG = LogManager.getLogger(UserController.class);
	
	@Resource // @Autowired
	private IUserService userService; 
		
	@ResponseBody // 按照对象方式处理返回结果
	@RequestMapping(value = "/list1", produces = ESysConstant.APP_JSON) // 映射URL，并安装json格式返回数据
	public GridEuiVo<UserDto> getList () {
		List<User> list = userService.findAll ();
		List<UserDto> dtos = new UserEuiVo(list).getDtos();
		GridEuiVo<UserDto> grid = new GridEuiVo<UserDto> (Long.valueOf(dtos.size()), dtos);
		return grid;
	}
	
	@ResponseBody // 按照对象方式处理返回结果
	@RequestMapping(value = "/create", produces = ESysConstant.APP_JSON) // 映射URL，并安装json格式返回数据
	public WoResultCode create (UserDto dto, MultipartFile headImageFile) {
		try{
			String realteivePath = "upload/" + headImageFile.getOriginalFilename();
			String fullPath = WoUtil.getWoot() + "/" + realteivePath;
			headImageFile.transferTo(new File(fullPath));
			dto.setHeadImage(realteivePath);
		}catch(IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		userService.create(dto);
		return WoResultCode.getSuccessCode();
	}
	
	@ResponseBody
	@RequestMapping (value = "/delete", produces = ESysConstant.APP_JSON)
	public WoResultCode delete (UserDto dto) {
		userService.delete (dto);
		return WoResultCode.getSuccessCode();
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public WoResultCode update(UserDto userDto) {
		userService.update(userDto);
		return WoResultCode.getSuccessCode();
	}
	
	@ResponseBody
	@RequestMapping("/list")
	public GridEuiVo<UserDto> findUserByCondition(Long page, Long rows, String loginName) {
		List<User> users = userService.findUserByCondition((page-1)*rows, rows, loginName);
		List<UserDto> dtos = new UserEuiVo(users).getDtos();
		GridEuiVo<UserDto> grid = new GridEuiVo<UserDto> (Long.valueOf(dtos.size()), dtos);
		return grid;
	}
	
	@Resource
	@Qualifier("exportView")
	private View exportView;
	
	@RequestMapping(value="/export")
	public ModelAndView exportExcel() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setView(exportView);
		modelAndView.addObject("users", userService.findUserByCondition(0L, 10L, null));	
		return modelAndView;
	}
	
	@RequestMapping(value="/importForm")
	public String importForm() {
		return "user/importForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/import")
	public WoResultCode importExcle(MultipartFile woUserImportFile) {
		userService.importExcel(woUserImportFile);
		return WoResultCode.getSuccessCode();
	}
}
