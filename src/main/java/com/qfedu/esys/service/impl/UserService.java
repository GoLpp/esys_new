package com.qfedu.esys.service.impl;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.activiti.bpmn.model.BooleanDataObject;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.EnableLoadTimeWeaving;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.ESysException;
import com.qfedu.esys.dao.IUserDao;
import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.Role;
import com.qfedu.esys.entity.User;
import com.qfedu.esys.service.IUserService;
import com.qfedu.esys.util.ESysConstant;

@Service
@Transactional
public class UserService implements IUserService {
	private final static Logger LOG = LogManager.getLogger(UserService.class);

	@Resource // @Autowired
	private IUserDao userDao;
	
	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}

	@Override
	public void create(UserDto dto) {
		User user = dto.createEntity();
		userDao.create(user);
	}

	@Override
	public UserDto authenticate(String user, String password) {
		User u = userDao.findByLoginName (user);
		if (u == null) {
			throw new ESysException(ESysConstant.ERR_LOGIN);
		}
		if (!password.equals(u.getPassword())) {
			throw new ESysException(ESysConstant.ERR_LOGIN);
		}
		return new UserDto(u);
	}

	@Override
	public void update(UserDto userDto) {
		User user = userDto.createEntity();
		userDao.update(user);
	}

	@Override
	public void delete(UserDto dto) {
		String[] ids = WoUtil.splitIds(dto.getWoSelectedIds());
		for(String id : ids) {
			User user = new User();
			user.setId(id);
			userDao.delete(user);
		}
	}

	@Override
	public List<User> findUserByCondition(Long page, Long rows, String loginName) {
		return userDao.finUserByCondition(page, rows, loginName);
	}
 
	@Override
	public void importExcel(MultipartFile woUserImportFile) {
		
		Boolean bool = woUserImportFile.getOriginalFilename().endsWith(".xls");
		Workbook workbook = null;
		try { 
			InputStream inputStream = woUserImportFile.getInputStream();
			if(bool) {
				workbook = new HSSFWorkbook(inputStream); //2003
			}else{
				workbook = new XSSFWorkbook(inputStream);
			}
			Sheet sheet = workbook.getSheetAt(0);
			for(int i=1; i < sheet.getLastRowNum(); i++) {
				UserDto dto = new UserDto(); 
				dto.setLoginName(sheet.getRow(i).getCell(0).getStringCellValue());
				Cell cell = sheet.getRow(i).getCell(1);
				cell.setCellType(CellType.STRING);
				String password = cell.getStringCellValue();
				dto.setPassword(password);
				userDao.create(dto.createEntity());
			}
		} catch (IOException e) {
			e.printStackTrace();  
		}
	}

	@Override
	public void register(UserDto dto) {
		dto.setRoles("1");
		User user = dto.createEntity();
		userDao.create(user);
	}
}
