package org.apartment.service;

import org.apartment.domain.JoinKeeperVO;
import org.apartment.domain.JoinTenantVO;
import org.springframework.transaction.annotation.Transactional;

public interface MemberService {
	
	@Transactional
	public int joinTenantService(JoinTenantVO member);
	
	int countMember(String id);
	
	public int joinKeeperService(JoinKeeperVO keeper);
}
