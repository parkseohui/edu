package org.apartment.mapper;

import java.util.List;

import org.apartment.domain.LevyVO;

public interface LevyMapper {
	
	public int addLevy(LevyVO levy);
	
	public List<LevyVO> listLevy(LevyVO levy);


}
