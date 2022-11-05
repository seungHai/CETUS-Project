package com.cetus.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cetus.domain.CateVO;
import com.cetus.mapper.CateMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class CateServiceImpl implements CateService {

	private CateMapper mapper;
	
	@Override
	public List<CateVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}

	@Override
	public List<CateVO> get(String catecoderef) {
		return mapper.get(catecoderef);
	}
}
