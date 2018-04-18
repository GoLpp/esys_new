package com.zhu.esys.service.impl;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.zhu.common.entity.WoPage;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.dao.UserBookDao;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.dto.UserBookDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.entity.User;
import com.zhu.esys.entity.UserBook;
import com.zhu.esys.service.UserBookService;
@Service
@Transactional
public class UserBookServiceImpl implements UserBookService{
	private final static Logger LOG = LogManager.getLogger(UserBookServiceImpl.class);

	@Resource
	private UserBookDao bookDao;

	@Override
	public void create(UserBookDto dto, UserDto userDto) {
		UserBook userBook = dto.createEntity();
		User user = new User();
		user.setId(userDto.getId());
		userBook.setUser(user);
		bookDao.create(userBook);
	}

	@Override
	public void update(UserBookDto bookDto, UserDto userDto) {
		UserBook book = bookDao.findById(bookDto.getId());
		book.setBookName(bookDto.getBookName());
		book.setCounts(bookDto.getCounts());
		book.setUpTime(new Date());
		book.setUrl(bookDto.getUrl());
		bookDao.update(book);
	}

	@Override
	public void delete(String bookIds) {
		for(String id : bookIds.split(",")) {
			bookDao.deleteById(id);
		}
	}

	@Override
	public List<UserBookDto> getList(UserDto userDto, Long page, Long rows, String searchContent) {
		String whereOrderBy = "1=1";
		Map<String, Object> props = new HashMap<>();
		UserBookDto userBookDto = new UserBookDto();
		if(!WoUtil.isEmpty(searchContent)) {
			whereOrderBy = whereOrderBy + " and (e.bookName like :searchContent or e.author like :searchContent)";
			props.put("searchContent", '%' + searchContent + '%');
		}
		
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + " and e.user.is = :userId";
			props.put("userId", userDto.getId());
		}
		WoPage<UserBook> books = bookDao.findAllBy(whereOrderBy, Long.valueOf(page), Long.valueOf(rows), props);
		return userBookDto.gotDtos(books.getRows());
	}
}
