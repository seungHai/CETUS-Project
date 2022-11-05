package com.cetus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cetus.domain.CateVO;
import com.cetus.domain.ReplyVO;
import com.cetus.service.BoardService;
import com.cetus.service.CateService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/category/")
public class CategoryController {
	
	@Setter(onMethod_ = @Autowired)
	private CateService service;
	
	// 카테고리 조회
	@GetMapping(value = "/{catecode}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CateVO>> get(@PathVariable("catecode") String catecoderef){
		log.info("get..." + catecoderef);
		return new ResponseEntity<>(service.get(catecoderef), HttpStatus.OK);
	}
}
