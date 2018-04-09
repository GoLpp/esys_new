package com.zhu.esys.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.dto.UserDto;

public interface BinaryBookService {

	void create(BinaryBookDto dto);

	List<BinaryBookDto> findAll(String searchContent, Integer page, Integer rows);

	void update(BinaryBookDto dto);

	void delete(BinaryBookDto dto);

	void lendBook(BinaryBookDto dto, Map<String, Object> map);

	List<BinaryBookDto> tjBook(Long page, Long rows);

	void returnBook(String bookIds, UserDto userDto);

	void importExcel(InputStream in, String fileName) throws IOException;

}
