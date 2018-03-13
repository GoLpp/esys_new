package com.qfedu.esys.controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;
import com.qfedu.esys.vo.UserEuiVo;

import net.sf.ehcache.search.parser.Harness;

@Component("exportView")// 该注解可以被spring扫描
public class UserExcelView extends AbstractXlsxView {
	private final static Logger LOG = LogManager.getLogger(UserExcelView.class);

	// model：由ModelAndView.addObject(key, val)方法增加的数据组成
	// book：由springmvc创建，最终返回给前端的excel数据对象，springmvc负责把该对象写到response中去
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook book, HttpServletRequest req,
			HttpServletResponse response) throws Exception {
		// 1.获取Controller中设置的数据
		List<User> users1 = (List<User>)model.get("users");
		List<UserDto> users = new UserEuiVo(users1).getDtos();
		// 2.创建sheet页
		Sheet sh = book.createSheet("用户数据");
		// 3.创建标题行
		// 3.1.创建一行
		Row rHeader = sh.createRow(0);
		// 3.2.创建该行的第一个单元格
		Cell cHeader = rHeader.createCell(0, CellType.STRING);
		cHeader.setCellValue("登录名");
		// 3.3.创建该行的第二个单元格
		cHeader = rHeader.createCell(1, CellType.STRING);
		cHeader.setCellValue("密码");
		// 4.创建数据行
		for (int i = 0; i < users.size(); i ++) {
			UserDto u = users.get(i);
			// 5.设置数据行的数据
			Row r = sh.createRow(i + 1);
			Cell c = r.createCell(0, CellType.STRING);
			c.setCellValue(u.getLoginName());
			c = r.createCell(1, CellType.STRING);
			c.setCellValue(u.getPassword());
		}
		
	}
}
