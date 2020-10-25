package org.apartment.controller;

import java.util.HashMap;

import org.apartment.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@RestController
public class MemberRestController {

	@Autowired
	MemberMapper memberMapper;

	@PostMapping(value = "/signUpIdValidate", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String validateId(@RequestBody HashMap<String, Object> map) {
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();
		System.out.println(map.get("id"));
		if (!((String)map.get("id")).equals("")) {
			if (memberMapper.memberCount((String) map.get("id")) == 0) {
				obj.addProperty("status", "true");
				return gson.toJson(obj);
			}
		}
		obj.addProperty("status", "false");
		return gson.toJson(obj);
	}
	
	@PostMapping(value = "/keeper/admitUser", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String admitTenant(@RequestBody HashMap<String, Object> map) {
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();
		String number = String.valueOf(map.get("seq"));
		if(number != null) {
			System.out.println(number);
			if (!number.equals("")) {
				if (1 == memberMapper.admitTenant(Integer.parseInt(number))) {
					obj.addProperty("status", "true");
					return gson.toJson(obj);
				}
			}
		}

		obj.addProperty("status", "false");
		return gson.toJson(obj);
	}
}
