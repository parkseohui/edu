package org.apartment.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/tenant/upload/*")
public class UploadController {
	@GetMapping("/uploadAjax")
	public String uploadAjax(){
		log.info("upload ajax");
		return "uploadAjax";
	}
	@RequestMapping("/uploadForm")
	public String uploadForm(){
		log.info("upload form");
		return "uploadForm";
	}
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile,Model model){
		String uploadFolder="C://upload";
		for(MultipartFile multipartFile:uploadFile){
			log.info("upload file name:"+multipartFile.getOriginalFilename());
			log.info("upload File Size:"+multipartFile.getSize());
			
			File saveFile=new File(uploadFolder,multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				log.error(e.getMessage());
			}
		}
	}
	
	 @PostMapping("/uploadAjaxAction")
		 public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
		 String uploadFolder = "C://upload";
		
		 // make folder --------
//		 File uploadPath = new File(uploadFolder, getFolder());
//		 log.info("upload path: " + uploadPath);
//		
//		 if (uploadPath.exists() == false) {
//		 uploadPath.mkdirs();
//		 }
		 // make yyyy/MM/dd folder
		
		 for (MultipartFile multipartFile : uploadFile) {
		
		 log.info("-------------------------------------");
		 log.info("Upload File Name: " + multipartFile.getOriginalFilename());
		 log.info("Upload File Size: " + multipartFile.getSize());
		
		 String uploadFileName = multipartFile.getOriginalFilename();
		
		 // IE has file path
		 uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") +
		 1);
		 log.info("only file name: " + uploadFileName);
		
		 // File saveFile = new File(uploadFolder, uploadFileName);
		 File saveFile = new File(uploadFolder, uploadFileName);
		
		 try {
		 multipartFile.transferTo(saveFile);
		 } catch (Exception e) {
		 log.error(e.getMessage());
		 } // end catch
		
		 } // end for
		
		 }
	
}
