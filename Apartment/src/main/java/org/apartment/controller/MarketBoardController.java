package org.apartment.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import org.apartment.domain.Criteria;
import org.apartment.domain.CustomUser;
import org.apartment.domain.MarketBoardVO;
import org.apartment.domain.PageDTO;
import org.apartment.service.MarketBoardService;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/tenant/*")
@Log4j
@AllArgsConstructor
public class MarketBoardController {
	
	private MarketBoardService service;
	
	@RequestMapping(value="/testimg",method=RequestMethod.GET)
	public String home(){
		return "imgtest";
	}

	@PostMapping("/uploadAjaxAction" )
	 public void uploadAjaxPost(MultipartHttpServletRequest request) {
		 String uploadFolder = "C:\\upload";
		List<MultipartFile> fileList = request.getFiles("fnames");
	 for (MultipartFile multipartFile :	fileList) {
	
	 log.info("-------------------------------------");
	 log.info("Upload File Name: " + multipartFile.getOriginalFilename());
	 log.info("Upload File Size: " + multipartFile.getSize());
	
	 String uploadFileName = multipartFile.getOriginalFilename();
	 
	 uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
	 log.info("only file name: " + uploadFileName);
	
	 File saveFile = new File(uploadFolder, uploadFileName);
	
	 try {
	 multipartFile.transferTo(saveFile);
	 } catch (Exception e) {
	 log.error(e.getMessage());
	 } // end catch
	
	 } // end for
	
	 }
	
	 @GetMapping(value = "/download", produces =
		 MediaType.APPLICATION_OCTET_STREAM_VALUE)
		 @ResponseBody
		 public ResponseEntity<org.springframework.core.io.Resource> downloadFile(String fileName) {
		
		 log.info("download file: " + fileName);
		
		 org.springframework.core.io.Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		 log.info("resource: " + resource);
		
		 String resourceName = resource.getFilename();
		
		 HttpHeaders headers = new HttpHeaders();
		 try {
		 headers.add("Content-Disposition",
		 "attachment; filename=" + new String(resourceName.getBytes("UTF-8"),
		 "ISO-8859-1"));
		 } catch (UnsupportedEncodingException e) {
		 e.printStackTrace();
		 }
		 return new ResponseEntity<org.springframework.core.io.Resource>(resource,headers, HttpStatus.OK);
		 }
	
	@RequestMapping("/market/insertform")
	public String insert(){
		log.info("insertform실행");
		return "marketinsertform";
	}
	
//	@RequestMapping("/list")
//	public String list(Model model){
//		log.info("list실행");
//		model.addAttribute("list",service.getlist());
//		return "marketlist";
//	}
	
	@RequestMapping("/market/list")
	public String list(Criteria cri,Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		int userseq=user.getAptSeq();
		log.info("list실행" + cri);
		model.addAttribute("list",service.getlist(cri,userseq));
		int total=service.getTotal(cri);
		log.info("controller의 토탈"+total);
		model.addAttribute("pageMarker", new PageDTO(cri,total));
		return "marketlist";
	}
	
	@PostMapping("/market/register")
	public String register(MarketBoardVO market,RedirectAttributes rttr, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		market.setApt_seq(user.getAptSeq());
		log.info("register실행");
		service.register(market);
		rttr.addFlashAttribute("result",market.getSeq());
	
		return "redirect:/tenant/market/list";
	}
	
	@RequestMapping("/market/get")
	public String get(@RequestParam("seq") int seq,Model model) {
		log.info("get실행");
		model.addAttribute("product",service.get(seq));
		return "marketdetail";
	}
	
	@RequestMapping(value="/market/modify",method={RequestMethod.POST})
	public String modify(MarketBoardVO market,RedirectAttributes rttr) {
		log.info("modify실행");
		if(service.modify(market)){
			rttr.addFlashAttribute("result","success");	
		}
		return "redirect:/tenant/market/list";
	}
	
	@RequestMapping(value="/market/modify",method={RequestMethod.GET})
	public String modify(@RequestParam("seq") int seq,Model model) {
		model.addAttribute("product",service.get(seq));
		return "marketupdate";
	}
	
	@RequestMapping("/market/remove")
	public String remove(@RequestParam("seq") int seq,RedirectAttributes rttr) {
		log.info("remove실행");
		if(service.remove(seq)){
			rttr.addFlashAttribute("result","success");	
		}
		return "redirect:/tenant/market/list";
	}
	
}
