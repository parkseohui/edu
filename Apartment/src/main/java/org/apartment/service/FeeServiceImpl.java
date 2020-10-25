package org.apartment.service;

import java.util.List;

import org.apartment.domain.FeeRegisterVO;
import org.apartment.domain.FeeVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.MeterVO;
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
	public List<HouseholdVO> listDong(HouseholdVO dong) {
		
		log.info("listdong....." + dong);
		
		return mapper.listDong(dong);
	}
	
	@Override
	public List<FeeRegisterVO>  listFeeReg(int dong) {
		
		log.info("dong : "+ dong);
		
		return mapper.listFeeReg(dong);
	}
	
	@Override
	public UnitPriceVO getUnitPrice(int unitPriceSeq){
		
		log.info("unitPriceSeq" + unitPriceSeq);
		
		return mapper.getUnitPrice(unitPriceSeq);
	}
	
	@Override
	public int updateUnitPrice(UnitPriceVO unitPrice) {
		
		log.info("updateUnitPrice" + unitPrice);
		
		return mapper.updateUnitPrice(unitPrice);
	}
	
	
	@Override
	public int addMeter(MeterVO meter) {
		
		log.info(meter);
		
		return mapper.addMeter(meter);
	}
	
	
	@Override
	public int updateMeter(MeterVO meter) {
		
		log.info(meter);
		
		return mapper.updateMeter(meter);
	}
	

	@Override
	public int insertFee(FeeVO fee) {
		
		log.info("insertFee....." + fee);
		
		return mapper.insertFee(fee);
	}

	@Override
	public List<FeeVO> listFee(TenantVO user) {
		
		log.info("listFee.....");
		
		return mapper.listFee(user);
	}

	@Override
	public List<FeeVO> listFeeRowNum(TenantVO user) {
		
		log.info("list fee up to 6 order by paydate desc");
		
		return mapper.listFeeRowNum(user);
	}

}
