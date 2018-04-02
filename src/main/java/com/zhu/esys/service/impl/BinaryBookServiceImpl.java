package com.zhu.esys.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhu.common.entity.WoPage;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.dao.BinaryBookDao;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.service.BinaryBookService;
@Service
@Transactional
public class BinaryBookServiceImpl implements BinaryBookService{
	private final static Logger LOG = LogManager.getLogger(BinaryBookServiceImpl.class);

	@Resource
	private BinaryBookDao bookDao;
	
	@Override
	public void create(BinaryBookDto dto) {
		BinaryBook book = dto.createEntity();
		bookDao.create(book);
	}

	@Override
	public List<BinaryBookDto> findAll(String searchContent, Integer page, Integer rows) {
		String whereOrderBy = "";
		Map<String, Object> props = new HashMap<>();
		BinaryBookDto dto = new BinaryBookDto();
		if(!WoUtil.isEmpty(searchContent)) {
			whereOrderBy = whereOrderBy + "e.bookName like :searchContent or e.author like :searchContent"
					+ " or e.publish like :searchContent";
			props.put("searchContent", "%" + searchContent + "%");
			
		}
		WoPage<BinaryBook> books = bookDao.findAllBy(whereOrderBy, Long.valueOf(page), Long.valueOf(rows), props);
		return dto.dtos(books.getRows());
	}

	@Override
	public void update(BinaryBookDto dto) {
		BinaryBook book = dto.createEntity();
		book.setId(dto.getId());
		bookDao.update(book);
	}

	@Override
	public void delete(BinaryBookDto dto) {
		String[] ids = dto.getBookIds().split(",");
		for(String id : ids) {
			BinaryBook book = new BinaryBook();
			book.setId(id);
			bookDao.delete(book);
		}
	}	
}
