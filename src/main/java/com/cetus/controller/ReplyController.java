package com.cetus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cetus.domain.BoardVO;
import com.cetus.domain.Criteria;
import com.cetus.domain.ReplyVO;
import com.cetus.service.BoardService;
import com.cetus.service.ReplyService;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
public class ReplyController {
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;
	private BoardService b_service;
	
	// 댓글 등록
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO reply){
		log.info("ReplyVO: " + reply);
		int insertCount = service.register(reply);
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<> ("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 조회
	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("bno") long bno){
		log.info("getList............");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	
	// 특정 댓글 조회
	@GetMapping(value="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") long rno){
		log.info("get..............:" + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value = "{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") long rno){
		log.info("remove.......:" + rno);
		return service.remove(rno) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정
	// PUT :자원 전체 수정, 자원 내 모든 필드를 전달해야 함, 일부만 전달할 경우 전달되지 않은 필드는 모두 초기화 처리가 된다.
    // PATCH : 자원 일부 수정, 수정할 필드만 전송
    // @RequestMapping을 사용하는 이유는 여러개의 메소드를 받기 위해.
	// 쉽게 생각하면 PUT은 내용 전체 수정, PATCH는 일부 수정
	@RequestMapping(value = "/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH},
			consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("rno") long rno,
											@RequestBody ReplyVO vo){
		vo.setRno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		int modifyCount = service.modify(vo);
		log.info("reply modify count: " + modifyCount);
		return modifyCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
