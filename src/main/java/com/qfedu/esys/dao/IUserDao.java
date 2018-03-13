package com.qfedu.esys.dao;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;

public interface IUserDao {

	List<User> findAll();

	void create(User user);

	void delete(User user);

	User findByLoginName(String user);

	void update(User user);

	List<User> finUserByCondition(Long page, Long rows, String loginName);

}
