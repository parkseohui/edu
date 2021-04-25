package org.apartment.controller;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.CustomUser;
import org.apartment.domain.NoticeCriteria;
import org.apartment.domain.NoticePageDTO;
import org.apartment.domain.NoticeVO;
import org.apartment.service.NoticeService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/tenant/*")
@AllArgsConstructor
public class NoticeTenantController {

	private NoticeService service;
	
	@GetMapping("/listNotice")
	public String list(NoticeCriteria cri,Authentication auth, Model model){
		CustomUser user = (CustomUser) auth.getPrincipal();
		int userAptSeq = user.getAptSeq();
		log.info("list : " + cri);
		log.info(userAptSeq);

	model.addAttribute("list", service.getList(cri, userAptSeq));	
//	model.addAttribute("pageMaker", new NoticePageDTO(cri, 60));
	int total = service.getTotal(cri,userAptSeq);
	log.info("total: " + total);
	log.info(model);

	model.addAttribute("pageMaker", new NoticePageDTO(cri, total));
	return "/listNoticeTenant";
	}
	
	@GetMapping("/getNotice")
	public String get(@RequestParam("noticeSeq")int noticeSeq, @ModelAttribute("cri") NoticeCriteria cri, Model model){
		log.info("/get");
		log.info(cri);
		
		model.addAttribute("notice", service.get(noticeSeq));	
		service.plusCnt(noticeSeq);
		
		return "/getNoticeTenant";
	}

}
