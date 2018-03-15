package com.qfedu.esys.service;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;

public interface UserService {

	List<User> findAll();

	void create(UserDto dto);

	void delete(UserDto dto);

	UserDto authenticate(String user, String password);

	void update(UserDto userDto);

	List<User> findUserByCondition(Long page, Long rows, String loginName);

	void importExcel(MultipartFile woUserImportFile);

	void register(UserDto dto);

}
