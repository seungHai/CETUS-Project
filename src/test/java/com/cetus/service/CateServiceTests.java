package com.cetus.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cetus.domain.CateVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CateServiceTests {
	@Setter(onMethod_ = @Autowired)
	private CateService service;
	
	@Test
	public void testGetList() {
		log.info("testGetList....");
		List<CateVO> list = service.getList();
	}
}
