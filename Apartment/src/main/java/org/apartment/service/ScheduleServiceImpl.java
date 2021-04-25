package org.apartment.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apartment.domain.ScheduleVO;
import org.apartment.mapper.ScheduleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

	@Setter
	private ScheduleMapper mapper;
	
	@Override
	public int insertSchedule(ScheduleVO vo) {
		log.info("register......." + vo);
		return mapper.insertSchedule(vo);
	}

	@Override
	public int deleteSchedule(int scheduleSeq) {
		log.info("delete : " + scheduleSeq);

		return mapper.deleteSchedule(scheduleSeq);
	}

	@Override
	public int updateSchedule(ScheduleVO vo) {
		log.info("update : " + vo);
		return mapper.updateSchedule(vo);
	}

	@Override
	public List<ScheduleVO> listSchedule(@Param("aptSeq") int aptSeq, @Param("authority") String authority) {
		log.info("admit");
		return mapper.listSchedule(aptSeq, authority);
	}

	@Override
	public int admitSchedule(int scheduleSeq) {
		log.info("admit update");
		return mapper.admitSchedule(scheduleSeq);
	}

}
