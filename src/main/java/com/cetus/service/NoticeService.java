package com.cetus.service;

import java.util.List;

import com.cetus.domain.Criteria;
import com.cetus.domain.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> getList(Criteria cri);
	public NoticeVO read(int nno);
	public int register(NoticeVO nvo);
	public int remove(int nno);
	public int modify(NoticeVO nvo);
	public int getTotal();
}
