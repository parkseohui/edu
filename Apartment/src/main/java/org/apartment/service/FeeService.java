package org.apartment.service;

import java.util.List;

import org.apartment.domain.FeeRegisterVO;
import org.apartment.domain.FeeVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.MeterVO;
import org.apartment.domain.TenantVO;
import org.apartment.domain.UnitPriceVO;

public interface FeeService {
	
	public List<HouseholdVO> listDong(HouseholdVO dong);
	
	public List<FeeRegisterVO> listFeeReg(int dong);
	
	public UnitPriceVO getUnitPrice(int unitPriceSeq); 
	
	public int updateUnitPrice(UnitPriceVO unitPrice);
	
	public int addMeter(MeterVO meter);
	
	public int updateMeter(MeterVO meter);
	
	
	//public TenantVO findMember(TenantVO user);

	
	public int insertFee(FeeVO fee);
	
	public List<FeeVO> listFee(TenantVO user);
	
	public List<FeeVO>	listFeeRowNum(TenantVO user);

}
