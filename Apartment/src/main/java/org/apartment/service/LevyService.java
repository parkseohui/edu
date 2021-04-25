package org.apartment.service;

import java.util.List;

import org.apartment.domain.LevyVO;
import org.apartment.domain.UnitPriceVO;

public interface LevyService {

	public int addLevy(LevyVO levy);
	
	public List<LevyVO> listLevy(LevyVO levy);
	
}
