package com.cetus.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 회원 정보 테이블
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRegVO {
	private String id,pw,rpw,email,root;
	private boolean enabled;
	private List<AuthVO> authList;
	private int cash;
}
