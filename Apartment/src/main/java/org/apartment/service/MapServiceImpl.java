package org.apartment.service;

import org.apartment.domain.AptVO;
import org.apartment.mapper.MapMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class MapServiceImpl implements MapService{

	private MapMapper mapper;
	
	@Override
	public AptVO getXY(int apt_seq) {
		
		log.info("가져온다 xy");
		return mapper.getXY(apt_seq);
		
	}

}
