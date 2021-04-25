package org.apartment.controller;

import java.util.List;
import java.util.Map;

import org.apartment.domain.CustomUser;
import org.apartment.domain.PollOptionVO;
import org.apartment.service.PollService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/tenant/*")
@Log4j
@AllArgsConstructor
public class PollTenantController {

	private PollService service;

	@GetMapping("/pollTenantList")
	public String tenant_List(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		int aptseq = user.getAptSeq(); 
		log.info("list");
		model.addAttribute("list", service.PollOnList(aptseq));
		return "pollTenantList";
	}
	
	
	@PostMapping(value = "/pollOptionList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<PollOptionVO>> tenant_pollOptionList(@RequestBody Map<String, Object> seq) {
		log.info("option......");
		int pollSeq = (int) seq.get("pollSeq");
		log.info(pollSeq);
		return new ResponseEntity<>(service.PollOptionList(pollSeq), HttpStatus.OK);

	}

	@GetMapping("/pollSignUpload")
	public void tenant_signUpload() {
		log.info("signUpload..");
	}

}