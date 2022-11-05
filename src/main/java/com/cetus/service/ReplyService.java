package com.cetus.service;

import java.util.List;

import com.cetus.domain.Criteria;
import com.cetus.domain.ReplyVO;

public interface ReplyService {

    public int register(ReplyVO reply); 
    public ReplyVO get(Long rno); 
    public int modify(ReplyVO reply); 
    public int remove(Long rno); 
    public List<ReplyVO> getList(Criteria cri, Long bno);
	
}
