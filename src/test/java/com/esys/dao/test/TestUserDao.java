package com.esys.dao.test;
import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.qfedu.common.entity.WoResultCode;
import com.qfedu.esys.ESysException;
import com.qfedu.esys.dao.IUserDao;
import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;
import com.qfedu.esys.service.IUserService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={ "classpath:applicationContext.xml" })
public class TestUserDao {
	private final static Logger LOG = LogManager.getLogger(TestUserDao.class);
	
	@Resource
	private IUserDao userDao;
	
	@Resource
	private IUserService userService;
	
	@Test
	@Transactional
	@Rollback(true)
	public void test() {
		User user = new User();
		user.setLoginName("junitTest");
		user.setPassword("123456");
		userDao.create(user);
		User user2 = userDao.findByLoginName(user.getLoginName());
		
		Assert.assertEquals(true, user2.getPassword().equals("123456"));
	}
	
	@Test
	@Transactional
	@Rollback
	public void test1() {
		UserDto user = new UserDto();
		user.setLoginName("zhu");
		user.setPassword("123");
		try{
			userService.authenticate(user.getLoginName(), user.getPassword());
			Assert.assertEquals(true, WoResultCode.getSuccessCode().getCode()==1);
		}catch (ESysException e) {
			WoResultCode code = e.getCode();
			Assert.assertEquals(true, code.getCode()==102);
		}
	}
}
