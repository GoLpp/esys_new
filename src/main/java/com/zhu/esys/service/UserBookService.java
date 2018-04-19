package com.zhu.esys.service;

import java.util.List;

import com.zhu.esys.dto.UserBookDto;
import com.zhu.esys.dto.UserDto;

public interface UserBookService {

	void create(UserBookDto dto, UserDto userDto);

	void update(UserBookDto bookDto, UserDto userDto);

	void delete(String bookIds);

	List<UserBookDto> getList(UserDto userDto, Long page, Long rows, String searchContent);

	List<UserBookDto> getAll(Long page, Long rows, String searchContent);

	void tjBook(String bookIds);

}
