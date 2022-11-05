package com.cetus.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private String userid, userpw, username;
	private boolean enabled;
	private Date regdate, updatedate;
	private List<AuthVO> authList;
	// join해서 쓸 거기 때문에 권한 정보를 받아올 list생성 (타입은 AuthVO)
}
