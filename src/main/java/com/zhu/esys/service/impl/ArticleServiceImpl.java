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
import com.zhu.esys.dao.ArticleDao;
import com.zhu.esys.dto.ArticleDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.Article;
import com.zhu.esys.entity.User;
import com.zhu.esys.service.ArticleService;
import com.zhu.esys.util.ESysConstant;

import net.sf.ehcache.search.expression.And;
@Service
@Transactional
public class ArticleServiceImpl implements ArticleService{
	private final static Logger LOG = LogManager.getLogger(ArticleServiceImpl.class);
	
	@Resource
	private ArticleDao articleDao;

	@Override
	public void create(ArticleDto articleDto, UserDto userDto) {
		Article article = articleDto.createEntity();
		User user = new User();
		user.setId(userDto.getId());
		article.setUser(user);
		articleDao.create(article);
	}

	@Override
	public void update(ArticleDto dto) {
		Article article = articleDao.findById(dto.getId());
		article.setTitle(dto.getTitle());
		article.setContent(dto.getContent());
		articleDao.create(article);
	}

	@Override
	public void delete(String id) {
		String[] ids = id.split(",");
		for(String id1 : ids) {
			articleDao.deleteById(id1);
		}
	}

	@Override
	public List<ArticleDto> findAll(String searchContent, Long page, Long rows, Map<String, Object> map) {
		String whereOrderBy = "1=1";
		Map<String, Object> props = new HashMap<>();
		UserDto userDto = (UserDto) map.get(ESysConstant.SESSION_USER);
		if(null != searchContent) {
			whereOrderBy = whereOrderBy + " and (e.title like :searchContent or e.content like :searchContent)";
			props.put("searchContent",'%'+ searchContent +'%');
		}
		if(!userDto.isAdminAndBookAdmin()) {
			whereOrderBy = whereOrderBy + " and e.user.id = :userId";
			props.put("userId", userDto.getId());
		}
		WoPage<Article> articles = articleDao.findAllBy(whereOrderBy, page, rows, props);
		ArticleDto articleDto = new ArticleDto();
		return articleDto.gotDtos(articles.getRows());
	}

	@Override
	public List<ArticleDto> findTj(Long page, Long rows) {
		Map<String, Object> props = new HashMap<>();
		String whereOrderBy = "order by counts desc";
		WoPage<Article> articles = articleDao.findAllBy(whereOrderBy, page, rows, props);
		ArticleDto dto = new ArticleDto();
		return dto.gotDtos(articles.getRows());
	}
}
