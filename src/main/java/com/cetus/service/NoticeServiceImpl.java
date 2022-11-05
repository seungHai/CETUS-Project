package com.cetus.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cetus.domain.Criteria;
import com.cetus.domain.NoticeVO;
import com.cetus.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class NoticeServiceImpl implements NoticeService {

	private NoticeMapper mapper;
	
	@Override
	public List<NoticeVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getList(cri);
	}

	@Override
	public NoticeVO read(int nno) {
		log.info("read....");
		return mapper.get(nno);
	}

	@Override
	public int register(NoticeVO nvo) {
		log.info("register....");
		return mapper.insert(nvo);
	}

	@Override
	public int remove(int nno) {
		log.info("remove....");
		return mapper.delete(nno);
	}

	@Override
	public int modify(NoticeVO nvo) {
		log.info("modify....");
		return mapper.update(nvo);
	}

	@Override
	public int getTotal() {
		return mapper.getTotal();
	}
}
