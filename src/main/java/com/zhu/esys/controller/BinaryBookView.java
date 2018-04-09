package com.zhu.esys.controller;
import java.io.IOException;
import java.io.OutputStream;
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
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.zhu.common.util.WoUtil;

@Component("binaryBookView")
public class BinaryBookView extends AbstractXlsView{
	private final static Logger LOG = LogManager.getLogger(BinaryBookView.class);

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workBook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		workBook = new XSSFWorkbook();
		Sheet sheet1 = workBook.createSheet("书籍");
		Row row1 = sheet1.createRow(0);
		String[] cell = {"书名", "作者", "简介", "出版时间", "出版社"};
		createMyRow(row1, cell);
		setHeaderPostView(workBook, response);
	}
	
	private Row createMyRow(Row row,String[] cells) {
		for(int i = 0; i < cells.length; i++) {
			Cell cell = row.createCell(i, CellType.STRING);
			cell.setCellValue(cells[i]);
		}
		return row;
	}

	
	private void setHeaderPostView(Workbook workBook, HttpServletResponse response) throws IOException {
		String filename = "模板.xlsx";//设置下载时客户端Excel的名称     
	    response.setContentType("application/vnd.ms-excel"); 
	    filename = WoUtil.parseGBK(filename);
	    response.setHeader("Content-disposition", "attachment;filename=" + filename);     
	    OutputStream ouputStream = response.getOutputStream();     
	    workBook.write(ouputStream);     
	    ouputStream.flush();     
	    ouputStream.close();
	}

}
