package com.cetus.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CatePlusCri {
	private int pageNum;
	private int amount;
	private String catecode, catecoderef, search, id;
}
