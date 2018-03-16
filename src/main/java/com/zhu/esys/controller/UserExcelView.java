package com.zhu.esys.controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.User;
import com.zhu.esys.vo.UserEuiVo;

import net.sf.ehcache.search.parser.Harness;

@Component("exportView")
public class UserExcelView extends AbstractXlsxView {
	private final static Logger LOG = LogManager.getLogger(UserExcelView.class);

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook book, HttpServletRequest req,
			HttpServletResponse response) throws Exception {
		List<User> users1 = (List<User>)model.get("users");
		List<UserDto> users = new UserEuiVo(users1).getDtos();
		Sheet sh = book.createSheet("用户数据");
		Row rHeader = sh.createRow(0);
		Cell cHeader = rHeader.createCell(0, CellType.STRING);
		cHeader.setCellValue("登录名");
		cHeader = rHeader.createCell(1, CellType.STRING);
		cHeader.setCellValue("密码");
		for (int i = 0; i < users.size(); i ++) {
			UserDto u = users.get(i);
			Row r = sh.createRow(i + 1);
			Cell c = r.createCell(0, CellType.STRING);
			c.setCellValue(u.getLoginName());
			c = r.createCell(1, CellType.STRING);
			c.setCellValue(u.getPassword());
		}
		
	}
}
