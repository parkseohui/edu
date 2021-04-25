package org.apartment.service;

import java.util.List;

import org.apartment.domain.LevyVO;
import org.apartment.mapper.LevyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class LevyServiceImpl implements LevyService {

	@Setter(onMethod_= @Autowired)
	private LevyMapper mapper;
	
	@Override
	public int addLevy(LevyVO levy) {
		
		log.info("add " + levy);
		
		return mapper.addLevy(levy);
	}
	
	@Override
	public List<LevyVO> listLevy(LevyVO levy) {
		
		log.info("list " + levy);
		
		return mapper.listLevy(levy);
	}

	


}
