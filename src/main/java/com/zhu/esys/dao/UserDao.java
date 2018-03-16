package com.zhu.esys.dao;
import java.util.List;


import com.zhu.esys.entity.User;


public interface UserDao {

	List<User> findAll();

	void create(User user);

	void delete(User user);

	User findByLoginName(String user);

	void update(User user);

	List<User> finUserByCondition(Long page, Long rows, String loginName);

}
