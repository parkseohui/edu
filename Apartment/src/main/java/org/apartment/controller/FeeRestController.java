package org.apartment.controller;

import java.util.List;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.FeeRegisterVO;
import org.apartment.domain.FeeVO;
import org.apartment.domain.HouseholdVO;
import org.apartment.domain.MeterVO;
import org.apartment.domain.UnitPriceVO;
import org.apartment.service.FeeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/keeper/*")
@Log4j
@AllArgsConstructor
public class FeeRestController {
	
	private FeeService service;
	
	@GetMapping(value = "/listDong",
			   produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
			public ResponseEntity<List<HouseholdVO>> listDong(Authentication auth){
				CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
				keeper.getAptSeq();
				
				HouseholdVO dong = new HouseholdVO();
				
				dong.setAptSeq(keeper.getAptSeq());
				
				return new ResponseEntity<>(service.listDong(dong), HttpStatus.OK);
				}
	
	
	@GetMapping(value = "/listFeeReg/{dong}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<List<FeeRegisterVO>> listFeeReg(@PathVariable("dong") int dong){
		
		FeeRegisterVO feeRegister = new FeeRegisterVO();

		feeRegister.setDong(dong);
		
		return new ResponseEntity<>(service.listFeeReg(dong), HttpStatus.OK);
	}
	
	
	@GetMapping(value = "/getUnitPrice/{unitPriceSeq}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<UnitPriceVO> getUnitPrice(@PathVariable("unitPriceSeq") int unitPriceSeq ){
		
		return new ResponseEntity<>(service.getUnitPrice(unitPriceSeq), HttpStatus.OK);
	}
	
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/updateUnitPrice/{unitPriceSeq}",
								    consumes= "application/json" ,produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updateUnitPrice(@RequestBody UnitPriceVO unitPrice, @PathVariable("unitPriceSeq") int unitPriceSeq){
		
		unitPrice.setUnitPriceSeq(unitPriceSeq);
		
		log.info("unitPriceSeq : " +unitPriceSeq);
		log.info("update : " + unitPrice);
		
		return service.updateUnitPrice(unitPrice) == 1
				  	? new ResponseEntity<>("success", HttpStatus.OK)
				  	: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	@PostMapping(value = "/addMeter", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> addMeter(@RequestBody MeterVO meter){
		log.info("MeterVO : " + meter);
		
		int insertCount = service.addMeter(meter);
		
		log.info(" Add COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/updateMeter/{householdSeq}",
		    consumes= "application/json" ,produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updateMeter(@RequestBody MeterVO meter, @PathVariable("householdSeq") int householdSeq){
	
		meter.setHouseholdSeq(householdSeq);
	
		return service.updateMeter(meter) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	

/*	@GetMapping(value = "/findMember", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public void findMember(Model model, MemberVO user){
		
		model.addAttribute("member", service.findMember(user));
	}*/
	
	
//	@GetMapping(value = "/listFee/{memberSeq}",
//						   produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<FeeVO>> listFee(@PathVariable("memberSeq") int memberSeq){
//		
//		MemberVO user = new MemberVO();
//		
//		user.setMemberSeq(memberSeq);
//		user.setAptSeq(6);
//		
//		return new ResponseEntity<>(service.listFee(user), HttpStatus.OK);
//	}
	
	
	@PostMapping(value = "/insertFee", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> insertFee(@RequestBody FeeVO fee){
		log.info("FeeVO : " + fee);
		
		int insertCount = service.insertFee(fee);
		
		log.info("Insert Fee COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
