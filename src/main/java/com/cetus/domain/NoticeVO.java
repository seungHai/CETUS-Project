package com.cetus.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	private int nno;
	private String ntitle, ncontent,nwriter;
	private Date nreg_date;
}
