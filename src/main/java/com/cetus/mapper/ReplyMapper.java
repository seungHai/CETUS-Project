package com.cetus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cetus.domain.Criteria;
import com.cetus.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(long bno);
	
	public int delete(long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") long bno);
	
}
