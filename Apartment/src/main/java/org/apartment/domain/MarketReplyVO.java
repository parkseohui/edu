package org.apartment.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class MarketReplyVO implements Serializable{
	private int replyNo;
	private int replyWriter;
	private String replyContents;
	private Date replyRegdate;
	private Date replyUpdatedate;
	private int seq;
}
