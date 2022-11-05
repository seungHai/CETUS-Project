package com.cetus.mapper;

import java.util.List;

import com.cetus.domain.Criteria;
import com.cetus.domain.NoticeVO;

public interface NoticeMapper {
	public List<NoticeVO> getList(Criteria cri);
	public NoticeVO get(int nno);
	public int insert(NoticeVO nvo);
	public int delete(int nno);
	public int update(NoticeVO nvo);
	public int getTotal();
}
