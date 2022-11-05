package com.cetus.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 명칭은 조금씩 다름 paging이라고 쓰는경우도 있음

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Criteria {
	private int pageNum;
	private int amount;
}
