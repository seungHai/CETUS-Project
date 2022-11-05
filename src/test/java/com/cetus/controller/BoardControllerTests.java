package com.cetus.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//controller 쓰려면 servlet-context가 필요하고,
//mapper, service쓰려면 root-context 필요하기 때문에 배열로 둘다선언
@ContextConfiguration(
		{ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" }
		)
@WebAppConfiguration
@Log4j
public class BoardControllerTests {
	
	// ctx 컨테이너 객체 가져온다.
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	// 가짜 mvc를 이용할 수 있게 해줌. 가상으로 url과 파라미터등을 실제 브라우저처럼 사용할 수 있게
	private MockMvc mockMvc;
	
	// AOP사용 미리 실행될 애들 - junit꺼 써야함
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();	// 가짜 mvc객체 빌드해주는거
	}
	
	// 컨트롤러의 테스트들은 전부 예외가 발생할 수 있으므로 throws Exception 처리해준다.
	
	@Test
	public void testList() throws Exception {
		log.info("*****************testList*****************");
		log.info(
					mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
					.andReturn()
					.getModelAndView()
					.getModelMap()
				);
	}
}
