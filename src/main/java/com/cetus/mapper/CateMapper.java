package com.cetus.mapper;

import java.util.List;

import com.cetus.domain.CateVO;

public interface CateMapper {
	public List<CateVO> getList();
	public List<CateVO> get(String catecoderef);
}
