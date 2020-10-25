package org.apartment.mapper;

import java.util.List;

import org.apartment.domain.LevyVO;
import org.apartment.domain.UnitPriceVO;

public interface LevyMapper {
	
	public int addLevy(LevyVO levy);
	
	public List<LevyVO> listLevy(LevyVO levy);
	
	public UnitPriceVO findUnitPriceSeq(String levyDate);

}
