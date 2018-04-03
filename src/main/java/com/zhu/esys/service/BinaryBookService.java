package com.zhu.esys.service;

import java.util.List;
import java.util.Map;

import com.zhu.esys.dto.BinaryBookDto;

public interface BinaryBookService {

	void create(BinaryBookDto dto);

	List<BinaryBookDto> findAll(String searchContent, Integer page, Integer rows);

	void update(BinaryBookDto dto);

	void delete(BinaryBookDto dto);

	void lendBook(BinaryBookDto dto, Map<String, Object> map);

}
