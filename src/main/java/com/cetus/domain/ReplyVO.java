package com.cetus.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {
	private long rno;
	private long bno;
	private String reply;
	private String replyer;
	private Date reply_date;
	private Date reply_updateDate;
}
