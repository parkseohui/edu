package org.apartment.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apartment.domain.ScheduleVO;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;


public interface ScheduleService {

//	public List<ScheduleVO> listSchedule(int aptSeq);
	public List<ScheduleVO> listSchedule(@Param("aptSeq") int aptSeq, @Param("authority") String authority);
	public int insertSchedule(ScheduleVO vo);
	public int deleteSchedule(int scheduleSeq);
	public int updateSchedule(ScheduleVO vo);
	public int admitSchedule(int scheduleSeq);

}
