package com.cetus.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cetus.domain.UserRegVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserRegServiceTests {
	@Setter(onMethod_ = @Autowired)
	private UserRegService service;
	
	@Test
	public void testGetList() {
		List<UserRegVO> list = service.getList();
		log.info("getList......");
		for(UserRegVO vo : list) {
			log.info(vo);
		}
	}
}
