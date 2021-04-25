package org.apartment.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apartment.domain.FeeRegisterVO;
import org.apartment.domain.FeeVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.LevyVO;
import org.apartment.domain.MeterVO;
import org.apartment.domain.TenantFeeInfoVO;
import org.apartment.domain.TenantVO;
import org.apartment.domain.UnitPriceVO;

public interface FeeService {
	
public List<HouseholdVO> listDong(int aptSeq);
	
	public List<FeeRegisterVO> listFeeReg(@Param("levySeq") int levySeq, @Param("dong") int dong);
	
	public List<HouseholdVO> householdInfo(int aptSeq);
	
	public LevyVO levyInfo(@Param("aptSeq") int aptSeq, @Param("levyDate") String levyDate);
	
	public int addFee(FeeVO fee);
	
	public int updateFee(FeeVO fee);
	
	public List<TenantFeeInfoVO> tenantFeeInfo(@Param("memberSeq") int memberSeq, @Param("rownum") int rownum);

}
