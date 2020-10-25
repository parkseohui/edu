package org.apartment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apartment.domain.FeeRegisterVO;
import org.apartment.domain.FeeVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.MeterVO;
import org.apartment.domain.UnitPriceVO;
import org.apartment.domain.TenantVO;
public interface FeeMapper {
	
	public List<HouseholdVO> listDong(HouseholdVO dong);
	
	public List<FeeRegisterVO> listFeeReg(int dong);
	
	public UnitPriceVO getUnitPrice(int unitPriceSeq); 
	
	public int updateUnitPrice(UnitPriceVO unitPrice);
	
	public int addMeter(MeterVO meter);
	
	public int updateMeter(MeterVO meter);
	
	
//	public TenantVO findMember(TenantVO user);
	
	public int insertFee(FeeVO fee);
	
	public List<FeeVO> listFee(TenantVO user);
	
	public List<FeeVO>	listFeeRowNum(TenantVO user);
}
