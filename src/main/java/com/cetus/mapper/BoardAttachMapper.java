package com.cetus.mapper;

import java.util.List;

import com.cetus.domain.BoardAttachVO;


public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(long bno);
	public void deleteAll(long bno);
}
