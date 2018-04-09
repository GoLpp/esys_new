package com.zhu.esys.service.impl;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zhu.common.WoException;
import com.zhu.common.entity.WoPage;
import com.zhu.common.entity.WoResultCode;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.ESysException;
import com.zhu.esys.dao.BinaryBookDao;
import com.zhu.esys.dao.LendRecordDao;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.entity.LendRcord;
import com.zhu.esys.entity.User;
import com.zhu.esys.service.BinaryBookService;
import com.zhu.esys.util.ESysConstant;

@Service
@Transactional
public class BinaryBookServiceImpl implements BinaryBookService{
	private final static Logger LOG = LogManager.getLogger(BinaryBookServiceImpl.class);

	@Resource
	private BinaryBookDao bookDao;
	
	@Resource
	private LendRecordDao lendRecordDao;
	
	@Override
	public void create(BinaryBookDto dto) {
		BinaryBook book = dto.createEntity();
		bookDao.create(book);
	}

	@Override
	public List<BinaryBookDto> findAll(String searchContent, Integer page, Integer rows) {
		String whereOrderBy = "1=1";
		Map<String, Object> props = new HashMap<>();
		BinaryBookDto dto = new BinaryBookDto();
		if(!WoUtil.isEmpty(searchContent)) {
			whereOrderBy = whereOrderBy + " and (e.bookName like :searchContent or e.author like :searchContent"
					+ " or e.publish like :searchContent)";
			props.put("searchContent", '%' + searchContent + '%');
			
		}
		whereOrderBy = whereOrderBy + " and e.statu = :statu";
		props.put("statu", "1");
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

	@Override
	public void lendBook(BinaryBookDto dto, Map<String, Object> map) {
		UserDto user = (UserDto) map.get(ESysConstant.SESSION_USER);
		User u = new User();
		u.setId(user.getId());
		String[] ids = dto.getBookIds().split(",");
		onlyFiveBook(user, ids);
		for(String id : ids) {
			BinaryBook book = bookDao.findById(id);
			LendRcord record = new LendRcord();
			book.setStatu("0");
			book.setCounts(book.getCounts()+1);
			record.setUser(u);
			record.setStatu("0");
			record.setBinaryBook(book);
			record.setLendTime(new Date());
			bookDao.update(book);
			lendRecordDao.create(record);
		}
	}
	
	/**
	 * 
	 * @Title: onlyFiveBook 
	 * @Description: 用户借书不能超过五本  0是未归还
	 * @param @param user
	 * @param @param ids
	 * @return void 
	 * @throws
	 */
	private void onlyFiveBook(UserDto user, String[] ids) {
		Integer count = 0;
		String whereOrderBy = "";
		Map<String, Object> props = new HashMap<>();
		whereOrderBy = "where e.user.id = :id and e.statu = :statu";
		props.put("id", user.getId());
		props.put("statu", "0");
		List<LendRcord> recods = lendRecordDao.findAllBy(whereOrderBy, props);
		count = ids.length + recods.size();
		if(count > 5) {
			throw new ESysException(new WoResultCode(132, "借书不能超过五本，请归还多余书籍"), "借书不能超过五本，请归还多余书籍");
		}
	}

	@Override
	public List<BinaryBookDto> tjBook(Long page, Long rows) {
		String whereOrderBy = "order by counts desc";
		Map<String, Object> props = new HashMap<>();
		WoPage<BinaryBook> books = bookDao.findAllBy(whereOrderBy, page, rows, props);
		BinaryBookDto bookDto = new BinaryBookDto();
		return bookDto.dtos(books.getRows());
	}

	@Override
	public void returnBook(String bookIds, UserDto userDto) {
		String whereOrderBy = "";
		String userId = userDto.getId();
		Map<String, Object> props = new HashMap<>();
		for(String id : bookIds.split(",")) {
			BinaryBook book = bookDao.findById(id);
			book.setStatu("1");
			whereOrderBy = whereOrderBy + "where e.user.id = :userId and e.binaryBook.id = :bookId and e.returnTime is null";
			props.put("userId", userId);
			props.put("bookId", id);
			List<LendRcord> records = lendRecordDao.findAllBy(whereOrderBy, props);
			LendRcord lendRcord = records.get(0);
			lendRcord.setStatu("1");
			lendRcord.setReturnTime(new Date());
			
			bookDao.update(book);
			lendRecordDao.update(lendRcord);
		}
	}
}
