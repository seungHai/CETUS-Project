package com.cetus.mapper;

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
public class NoticeMapperTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
//	@Test
//	public void testGetList() {
//		log.info("testGetList....");
//		List<NoticeVO> list = mapper.getList();
//		for(NoticeVO vo : list) {
//			log.info(vo);
//		}
//	}
	
//	@Test
//	public void testGet() {
//		log.info("testGet....");
//		NoticeVO nvo = mapper.get(1);
//			log.info(nvo);
//	}
	
//	@Test
//	public void testInsert() {
//		log.info("testInsert....");
//		NoticeVO nvo = new NoticeVO();
//		nvo.setNtitle("공지 테스트");
//		nvo.setNwriter("admin_test");
//		nvo.setNcontent("공지 테스트 입니다.");
//		int result = mapper.insert(nvo);
//		if(result > 0) {
//			log.info("*************** 데이터 삽입 성공****************");
//		}
//	}
	
//	@Test
//	public void testUpdate() {
//		log.info("testUpdate....");
//		NoticeVO nvo = new NoticeVO();
//		nvo.setNno(3);
//		nvo.setNtitle("공지 테스트222");
//		nvo.setNwriter("admin_test222");
//		nvo.setNcontent("공지 테스트222 입니다.");
//		int result = mapper.update(nvo);
//		if(result > 0) {
//			log.info("*************** 데이터 변경 성공****************");
//		}
//	}
	
	@Test
	public void testDelete() {
		log.info("testDelete...");
		int result = mapper.delete(4);
		if(result > 0) {
			log.info("*************** 데이터 삭제 성공****************");
		}
	}
}
