package com.cetus.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberTests {
	
	// datasource 객체, passwordencoder 객체
	@Setter(onMethod_ = @Autowired)
	private DataSource ds; // 한번만 넣을거라서 sqlSession(mybatis)사용 안할거임
	// sql꺼 가져와야함
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
//	@Test
//	public void testInsertMember() {
//		
//		String sql ="insert into tbl_member(userid, userpw, username)" +
//					"values(?,?,?)";
//		for(int i=0; i<100; i++) {
//			
//			Connection con = null;
//			PreparedStatement ps = null;
//			
//			try {
//				
//				con = ds.getConnection();
//				ps = con.prepareStatement(sql);
//				
//				// 비밀번호는 인덱스번호로 들어갈거임
//				
//				ps.setString(2, pwencoder.encode("pw" + i));
//				
//				// id/이름
//				// 80번 아래로 일반회원 , 90번 아래로 회원 이상은 관리자
//				if(i<80) {
//					ps.setString(1, "user"+i);
//					ps.setString(3, "일반사용자"+i);
//				}else if(i<90) {
//					ps.setString(1, "manager"+i);
//					ps.setString(3, "운영자"+i);
//				}else {
//					ps.setString(1, "admin"+i);
//					ps.setString(3, "관리자"+i);
//				}
//				
//				ps.executeUpdate();
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}finally {
//				try {
//					if(ps!=null) {ps.close();}
//					if(con!=null) {con.close();}
//				} catch (Exception e2) {
//					e2.printStackTrace();
//				}
//			}
//			
//		}// end for loop
//	}
	
	@Test
	public void testInsertAuth() {
		
		String sql ="insert into tbl_member_auth(userid, auth)" +
					"values(?,?)";
		for(int i=0; i<100; i++) {
			
			Connection con = null;
			PreparedStatement ps = null;
			
			try {
				
				con = ds.getConnection();
				ps = con.prepareStatement(sql);
				
				// id/권한
				// 80번 아래로 ROLE_USER , 90번 아래로 ROLE_MEMBER 이상은 ROLE_ADMIN
				if(i<80) {
					ps.setString(1, "user"+i);
					ps.setString(2, "ROLE_USER");
				}else if(i<90) {
					ps.setString(1, "manager"+i);
					ps.setString(2, "ROLE_MEMBER");
				}else {
					ps.setString(1, "admin"+i);
					ps.setString(2, "ROLE_ADMIN");
				}
				
				ps.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(ps!=null) {ps.close();}
					if(con!=null) {con.close();}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
		}// end for loop
	}
}


