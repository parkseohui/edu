package org.apartment.mapper;

import java.util.List;

import org.apartment.domain.AptVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.JoinTenantVO;

public interface AptMapper {
	public int aptCount(AptVO apt);
	public int insertApt(AptVO apt);
	public List<AptVO> searchWithKeyword(String keyword);
	public HouseholdVO getHousehold(JoinTenantVO member);
	public int createHousehold(JoinTenantVO memberVO);
}
