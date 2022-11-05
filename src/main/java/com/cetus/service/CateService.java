package com.cetus.service;

import java.util.List;

import com.cetus.domain.CateVO;

public interface CateService {
	public List<CateVO> getList();
	public List<CateVO> get(String catecoderef);
}
