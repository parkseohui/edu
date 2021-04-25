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
import org.apartment.mapper.FeeMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FeeServiceImpl implements FeeService {
	
	private FeeMapper mapper;
	
	@Override
	public List<HouseholdVO> listDong(int aptSeq) {
		
		log.info("listdong....." + aptSeq);
		
		return mapper.listDong(aptSeq);
	}
	
	@Override
	public List<FeeRegisterVO>  listFeeReg(@Param("levySeq") int levySeq, @Param("dong") int dong) {
		
		log.info("levySeq : " + levySeq + "dong : "+ dong);
		
		return mapper.listFeeReg(levySeq, dong);
	}
	
	@Override
	public LevyVO levyInfo(@Param("aptSeq") int aptSeq, @Param("levyDate") String levyDate) {
		
		
		return mapper.levyInfo(aptSeq, levyDate);
	}
	
	
	
	
	@Override
	public List<HouseholdVO> householdInfo(int aptSeq) {
		
		return mapper.householdInfo(aptSeq);
	}	
	

	@Override
	public int addFee(FeeVO fee) {
		
		return mapper.addFee(fee);
	}
	

	@Override
	public int updateFee(FeeVO fee) {
		
		
		return mapper.updateFee(fee);
	}
	
	

	@Override
	public List<TenantFeeInfoVO> tenantFeeInfo(@Param("memberSeq") int memberSeq, @Param("rownum") int rownum) {
		
		log.info("memberSeq  : " + memberSeq + ", rownum : " + rownum);
		
		return mapper.tenantFeeInfo(memberSeq, rownum);
	}

}