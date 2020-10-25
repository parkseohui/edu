package org.apartment.controller;

import java.util.List;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.LevyVO;
import org.apartment.domain.UnitPriceVO;
import org.apartment.service.LevyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/keeper/*")
@Log4j
@AllArgsConstructor
public class LevyRestController {
	
	private LevyService service;
	
	
	@PostMapping(value = "/addLevy", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> addLevy(@RequestBody LevyVO levy, Authentication auth){
		log.info("LevyVO : " + levy);
		
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		levy.setAptSeq(keeper.getAptSeq());
		
		int insertCount = service.addLevy(levy);
		
		log.info("Levy Add COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/listLevy",
	   produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<LevyVO>> listLevy(Authentication auth){
		
		LevyVO levy = new LevyVO();
		
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		
		
		levy.setAptSeq(keeper.getAptSeq());
		
		return new ResponseEntity<>(service.listLevy(levy), HttpStatus.OK);
		}
	
	@GetMapping(value = "/findUnitPriceSeq/{levyDate}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<UnitPriceVO> findUnitPriceSeq(@PathVariable("levyDate") String levyDate ){
		
		return new ResponseEntity<>(service.findUnitPriceSeq(levyDate), HttpStatus.OK);
	}
	
}
