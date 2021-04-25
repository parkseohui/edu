package org.apartment.domain;

import lombok.Data;

@Data
public class ScheduleVO {
	private int scheduleSeq;
	private String title;
	private String contents;
	private String startDate;
	private String endDate;
	private int aptSeq;
	private String backgroundColor;
	private String dong;
	private String authority; 
	private String states; 
	
}