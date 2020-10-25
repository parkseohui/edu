package org.apartment.mapper;

import java.util.List;

import org.apartment.domain.JoinKeeperVO;
import org.apartment.domain.JoinTenantVO;
import org.apartment.domain.KeeperVO;
import org.apartment.domain.TenantVO;

public interface MemberMapper {
	int memberCount(String member);

	int joinTenant(JoinTenantVO member);

	TenantVO memberInfo(String username);

	int joinKeeper(JoinKeeperVO keeper);

	int keeperCount(String id);

	KeeperVO keeperInfo(String username);

	List<TenantVO> showNotAdmitUser(int seq);

	int admitTenant(int seq);

}
