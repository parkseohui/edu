package org.apartment.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apartment.domain.CustomUser;
import org.apartment.domain.PollChartVO;
import org.apartment.domain.PollLookupVO;
import org.apartment.domain.PollSelectVO;
import org.apartment.domain.PollVO;
import org.apartment.service.PollService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@RequestMapping("/tenant/*")
@Log4j
@AllArgsConstructor
public class PollTenantRestController {

	private PollService service;

	@GetMapping("/pollOnList")
	public @ResponseBody ResponseEntity<List<PollVO>> tenant_OnList(Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		int aptseq = user.getAptSeq();
		log.info("OnList");
		return new ResponseEntity<>(service.PollOnList(aptseq), HttpStatus.OK);
	}

	@GetMapping("/pollEndList")
	public @ResponseBody ResponseEntity<List<PollVO>> tenant_EndList(Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		int aptseq = user.getAptSeq();
		log.info("EndList");
		return new ResponseEntity<>(service.PollEndList(aptseq), HttpStatus.OK);
	}

	@PostMapping("/pollChart")
	public @ResponseBody ResponseEntity<List<PollChartVO>> tenant_Chart(@RequestBody Map<String, Object> seq) {
		log.info("Chart");
		int pollSeq = (int) seq.get("pollSeq");
		System.out.println(pollSeq);
		return new ResponseEntity<>(service.PollChart(pollSeq), HttpStatus.OK);
	}

	@PostMapping(value = "/pollSignUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String tenant_signUpload(PollSelectVO select, PollLookupVO lookup, Authentication auth,
			@RequestParam(value = "file") MultipartFile[] file, 
			@RequestParam(value = "optionSeq") String optionSeq,
			@RequestParam(value = "pollSeq") int pollSeq) throws Exception {
		CustomUser user = (CustomUser) auth.getPrincipal();
		int memberseq = user.getMemberSeq();
		int householdseq = user.getHouseholdSeq();
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();

		select.setMemberSeq(memberseq);

		String uploadFolder = "C:\\upload\\sign";
		String s_uploadFolder = "C:\\upload\\s_sign";

		File uploadPath = new File(uploadFolder);
		File s_uploadPath = new File(s_uploadFolder);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : file) {

			String uploadFileName = optionSeq;

			UUID uuid = UUID.randomUUID();

			uploadFileName = uploadFileName + "_" + uuid.toString() + ".png";

			try {

				if (s_uploadPath.exists() == false) {
					s_uploadPath.mkdirs();
				}

				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				FileOutputStream thumbnail = new FileOutputStream(new File(s_uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();

			} catch (Exception e) {
				e.printStackTrace();
				obj.addProperty("status", "false");
				return gson.toJson(obj);
			}

			select.setOptionSeq(Integer.parseInt(optionSeq));
			select.setFileName("s_" + uploadFileName);

			lookup.setHouseholdSeq(householdseq);
			lookup.setPollSeq(pollSeq);
		}

		if (0 == service.PollSelectLookup(lookup)) {
			service.PollSelectInsert(select, lookup);
			obj.addProperty("status", "true");
			System.out.println("obj : " + obj);
			return gson.toJson(obj);
		} else {
			obj.addProperty("status", "false");
			System.out.println("obj : " + obj);
			return gson.toJson(obj);
		}
	}
}