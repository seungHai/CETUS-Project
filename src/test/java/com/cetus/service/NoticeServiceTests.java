package com.cetus.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cetus.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeServiceTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeService service;
	
//	@Test
//	public void testGetList() {
//		log.info("testGetList...");
//		List<NoticeVO> list = service.getList();
//	}
//	
//	@Test
//	public void testGet() {
//		log.info("testGet....");
//		NoticeVO nvo = service.read(1);
//			log.info(nvo);
//	}
//	
//	@Test
//	public void testInsert() {
//		log.info("testInsert....");
//		NoticeVO nvo = new NoticeVO();
//		nvo.setNtitle("공지 테스트3");
//		nvo.setNwriter("admin_test3");
//		nvo.setNcontent("공지 테스트3 입니다.");
//		int result = service.register(nvo);
//		if(result > 0) {
//			log.info("*************** 데이터 삽입 성공****************");
//		}
//	}
//	
//	@Test
//	public void testUpdate() {
//		log.info("testUpdate....");
//		NoticeVO nvo = new NoticeVO();
//		nvo.setNno(5);
//		nvo.setNtitle("공지 테스트333");
//		nvo.setNwriter("admin_test333");
//		nvo.setNcontent("공지 테스트333 입니다.");
//		int result = service.modify(nvo);
//		if(result > 0) {
//			log.info("*************** 데이터 변경 성공****************");
//		}
//	}
//	
	@Test
	public void testDelete() {
		log.info("testDelete...");
		int result = service.remove(3);
		if(result > 0) {
			log.info("*************** 데이터 삭제 성공****************");
		}
	}
}
