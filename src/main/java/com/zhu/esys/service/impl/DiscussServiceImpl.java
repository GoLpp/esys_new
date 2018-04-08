package com.zhu.esys.service.impl;

import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.zhu.esys.dao.DiscussDao;
import com.zhu.esys.dto.DiscussDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.Article;
import com.zhu.esys.entity.Discuss;
import com.zhu.esys.entity.User;
import com.zhu.esys.service.DiscussService;
import com.zhu.esys.util.ESysConstant;

@Service
@Transactional
public class DiscussServiceImpl implements DiscussService{
	
	@Resource
	private DiscussDao discussDao;

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
	
	
}
