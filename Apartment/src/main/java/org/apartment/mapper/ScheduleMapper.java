package org.apartment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apartment.domain.ScheduleVO;

public interface ScheduleMapper {
//	@Select("select * from schedule")
	public ScheduleVO allSchedule(int scheduleSeq);
//	public List<ScheduleVO> listSchedule(int aptSeq);
	public List<ScheduleVO> listSchedule(@Param("aptSeq") int aptSeq, @Param("authority") String authority);
	public int insertSchedule(ScheduleVO vo);
	public int deleteSchedule(int scheduleSeq);
	public int updateSchedule(ScheduleVO vo);
	public int admitSchedule(int scheduleSeq);
}
