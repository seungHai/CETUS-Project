package com.cetus.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {
	//@Autowired
	// bean으로 생성되어있는 객체를 가져와서 쓰겠다.
	@Setter(onMethod_ = @Autowired) // -> setter역활 값을 가져와서 저장함
	private DataSource dataSource; // -> 필드만 보이지만 rootContext에 세팅된 값이 들어간상태
	
	@Setter(onMethod_ = @Autowired)
	private SqlSessionFactory sqlSessionFactory;
	
	// 메소드를 실행해서 실행되면 테스트가 성공한것 어노테이션 붙이면 됨
	
	@Test
	// 일반적인 예외처리랑 다름 try옆 ()안에 할 내용들어가고 {}안에는 성공후에 실행할 내용 작성함
	public void testConnection() {
		try(Connection con = dataSource.getConnection()) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testMyBatis() {
		try(
			SqlSession sqlSession = sqlSessionFactory.openSession();
			Connection con = sqlSession.getConnection();
			) {
			log.info(sqlSession);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
}
