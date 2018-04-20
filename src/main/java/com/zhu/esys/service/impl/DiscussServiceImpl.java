package com.zhu.esys.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.zhu.common.entity.WoPage;
import com.zhu.esys.dao.BookDiscussDao;
import com.zhu.esys.dao.DiscussDao;
import com.zhu.esys.dto.BookDiscussDto;
import com.zhu.esys.dto.DiscussDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.Article;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.entity.BookDiscuss;
import com.zhu.esys.entity.Discuss;
import com.zhu.esys.entity.User;
import com.zhu.esys.service.DiscussService;
import com.zhu.esys.util.ESysConstant;

@Service
@Transactional
public class DiscussServiceImpl implements DiscussService{
	
	@Resource
	private DiscussDao discussDao;
	
	@Resource
	private BookDiscussDao bookDiscussDao;
	
	@Override
	public void create(Map<String, Object> map, DiscussDto dto) {
		UserDto dto2 = (UserDto) map.get(ESysConstant.SESSION_USER);
		Discuss discuss = dto.createEntity();
		
		User user = new User();
		user.setId(dto2.getId());
		Article article = new Article();
		article.setId(dto.getArticleId());
		
		discuss.setArticle(article);
		discuss.setUser(user);
		discussDao.create(discuss);
	}

	@Override
	public void delete(String ids) {
		for(String id : ids.split(",")) {
			discussDao.deleteById(id);
		}
	}

	@Override
	public List<DiscussDto> getList(UserDto userDto, Long page, Long rows) {
		String whereOrderBy = "1=1";
		DiscussDto discussDto = new DiscussDto();
		Map<String, Object> props = new HashMap<>();
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + " and e.user.id = :userId";
		}
		WoPage<Discuss> discuss = discussDao.findAllBy(whereOrderBy, page, rows, props);
		return discussDto.gotDtos(discuss.getRows());
	}

	@Override
	public void createBookDiscuss(UserDto userDto, BookDiscussDto dto) {
		User user = userDto.createEntity();
		BinaryBook book = new BinaryBook();
		book.setId(dto.getBookId().split(",")[0]);
		BookDiscuss bookDiscuss = dto.createEntity();
		bookDiscuss.setUser(user);
		bookDiscuss.setBinaryBook(book);
		bookDiscussDao.create(bookDiscuss);
	}

	@Override
	public List<BookDiscussDto> findBookDiscuss(String bookId) {
		String whereOrderBy = "where e.binaryBook.id = :bookId";
		Map<String, Object> props = new HashMap<>();
		BookDiscussDto dto = new BookDiscussDto();
		props.put("bookId", bookId);
		whereOrderBy = whereOrderBy + " order by createTime desc";
		List<BookDiscuss> dtos = bookDiscussDao.findAllBy(whereOrderBy, props);
		return dto.gotDtos(dtos);
	}

	@Override
	public List<BookDiscussDto> findAllBookDiscuss() {
		List<BookDiscuss> findAll = bookDiscussDao.findAll();
		return new BookDiscussDto().gotDtos(findAll);
	}

	@Override
	public List<DiscussDto> getById(String articleId, Long page, Long rows) {
		String whereOrderBy = "where e.article.id = :articleId";
		Map<String, Object> props = new HashMap<>();
		props.put("articleId", articleId);
		whereOrderBy = whereOrderBy + " order by createTime desc";
		WoPage<Discuss> dtos = discussDao.findAllBy(whereOrderBy, page, rows, props);
		return new DiscussDto().gotDtos(dtos.getRows());
	}
}
