package org.apartment.controller;


import java.util.List;



import org.apartment.domain.CustomUser;
import org.apartment.domain.ScheduleVO;
import org.apartment.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/tenant/*")
@Log4j
public class ScheduleTenantRestController {
	
	@Autowired
	private ScheduleService service;

	@GetMapping(value = "/listSchedule", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public String tenant_ShowSchedule(Authentication auth) {
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		int tenantAptSeq = user.getAptSeq();
		
		List<ScheduleVO> list = service.listSchedule(tenantAptSeq, "1"); 
		log.info("list" + list);
		
		Gson gson = new Gson();
		JsonArray array = new JsonArray();
		for(ScheduleVO schedule: list){
			JsonObject tmp = new JsonObject();
			tmp.addProperty("_id", schedule.getScheduleSeq());
			tmp.addProperty("title", schedule.getTitle());
			tmp.addProperty("contents", schedule.getContents());
			tmp.addProperty("start", schedule.getStartDate());
			tmp.addProperty("end", schedule.getEndDate());
			tmp.addProperty("allDay", "false");
			tmp.addProperty("dong", schedule.getDong());
			tmp.addProperty("backgroundColor", schedule.getBackgroundColor());
			tmp.addProperty("authority", schedule.getAuthority());
			tmp.addProperty("states", schedule.getStates());
			array.add(tmp);
		}
		return gson.toJson(array);
	}
	

	@PostMapping(value="/insertSchedule", consumes="application/json", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String tenant_CreateSchedule(@RequestBody ScheduleVO vo, Authentication auth){

		 vo.setAuthority("0");
		 log.info("scheduleVO: " + vo);
		int insertCount = service.insertSchedule(vo);
		JsonObject obj = new JsonObject();	
		Gson gson = new Gson(); 
		
		if(insertCount == 1 )
				obj.addProperty("status", "true");
		else
				obj.addProperty("status", "false");
		return gson.toJson(obj);
	}
	
	
	@DeleteMapping(value="/{scheduleSeq}", 
									produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String tenant_DeleteSchedule(@PathVariable("scheduleSeq")int scheduleSeq){
		log.info("schedule delete: "+ scheduleSeq);
		
		int seq = service.deleteSchedule(scheduleSeq);
		JsonObject obj = new JsonObject();
		Gson gson = new Gson(); 
		
		if (seq ==1)
			obj.addProperty("status", "true");
		else
			obj.addProperty("status", "false");
		
		return gson.toJson(obj);
				
	}
	
	@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH},
			value="/{scheduleSeq}",  consumes="application/json", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String tenant_UpdateSchedule( @RequestBody ScheduleVO vo, @PathVariable("scheduleSeq")int scheduleSeq){
		log.info("schedule update seq :" + scheduleSeq);
		vo.setScheduleSeq(scheduleSeq);
		vo.setAuthority("0");
		log.info("schedule update : "+ vo);
		int modify = service.updateSchedule(vo);
		
		JsonObject obj = new JsonObject();
		Gson gson = new Gson(); 

		if(modify == 1 )
				obj.addProperty("status", "true");
		else
				obj.addProperty("status", "false");
		return gson.toJson(obj);	
	}
	

	
}