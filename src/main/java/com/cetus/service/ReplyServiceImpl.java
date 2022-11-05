package com.cetus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cetus.domain.Criteria;
import com.cetus.domain.ReplyVO;
import com.cetus.mapper.BoardMapper;
import com.cetus.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private BoardMapper b_mapper;
	
	@Override
	@Transactional
	public int register(ReplyVO reply) {
		log.info("register*************" + reply);
		b_mapper.updateReplyCnt(reply.getBno(), 1);
		return mapper.insert(reply);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get*************" + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		log.info("modify*************" + reply);
		return mapper.update(reply);
	}

	@Override
	@Transactional
	public int remove(Long rno) {
		log.info("remove*************" + rno);
		ReplyVO reply = mapper.read(rno);
		b_mapper.updateReplyCnt(reply.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board*************" + bno);
		return mapper.getListWithPaging(cri, bno);
	}
}
