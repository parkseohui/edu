package org.apartment.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.apartment.domain.AptCodeVO;
import org.apartment.domain.AptVO;
import org.apartment.domain.CustomUser;
import org.apartment.mapper.AptMapper;
import org.apartment.security.ApiKeys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/apt")
@Log4j
public class AptRestController {

	@Autowired
	private AptMapper aptMapper;

	@GetMapping(value = "/showAptList/{bjdCode}", produces = "application/json; charset=utf8")
	public String showAptList(@PathVariable("bjdCode") String bjdCode, Authentication auth) {
		final String USER_AGENT = "Mozilla/5.0";
		String url1 = "http://apis.data.go.kr/1611000/AptListService/getLegaldongAptList?bjdCode=";
		String url2 = "&numOfRows=100&ServiceKey=" + ApiKeys.getAptListKey();

		URL targetUrl;
		log.info(bjdCode);
		try {
			targetUrl = new URL(url1 + bjdCode + url2);
			log.info(url1 + bjdCode + url2);
			HttpURLConnection con = (HttpURLConnection) targetUrl.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", USER_AGENT);
			DocumentBuilder builder;
			Document doc = null;
			int responseCode = con.getResponseCode();
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			String inputLine;
			String responseString = new String();

			while ((inputLine = in.readLine()) != null) {
				responseString += inputLine;
			}
			in.close();
			if (responseCode == 200) {
				InputSource is = new InputSource(new StringReader(responseString));
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				doc = dBuilder.parse(is);
				XPathFactory xpathFactory = XPathFactory.newInstance();
				XPath xpath = xpathFactory.newXPath();

				XPathExpression expr = xpath.compile("//items/item");
				NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
				List<AptCodeVO> list = new ArrayList<AptCodeVO>();
				Gson gson = new Gson();
				for (int i = 0; i < nodeList.getLength(); i++) {
					NodeList child = nodeList.item(i).getChildNodes();
					AptCodeVO apt = new AptCodeVO();
					for (int j = 0; j < child.getLength(); j++) {
						Node node = child.item(j);
						log.info(node.getNodeName() + node.getTextContent());
						if (node.getNodeName().equals("kaptCode")) {
							apt.setKaptcode(node.getTextContent());
						} else if (node.getNodeName().equals("kaptName")) {
							apt.setAptName(node.getTextContent());
						}
					}
					list.add(apt);
				}
				Map<String, List> map = new HashMap<String, List>();
				map.put("aptInfo", list);
				return gson.toJson(map);
			}
			System.out.println(responseString);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "{\"status\": \"false\" }";

	}

	@GetMapping(value = "/aptdetail/{aptCode}", produces = "application/json; charset=utf8")
	public String showAptDetail(@PathVariable("aptCode") String aptCode) {
		final String USER_AGENT = "Mozilla/5.0";
		String url1 = "http://apis.data.go.kr/1611000/AptBasisInfoService/getAphusBassInfo?kaptCode=";
		String url2 = "&ServiceKey=" + ApiKeys.getAptDetailKey();

		URL targetUrl;
		try {
			targetUrl = new URL(url1 + aptCode + url2);
			log.info(url1 + aptCode + url2);
			HttpURLConnection con = (HttpURLConnection) targetUrl.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", USER_AGENT);
			DocumentBuilder builder;
			Document doc = null;
			int responseCode = con.getResponseCode();
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			String inputLine;
			String responseString = new String();

			while ((inputLine = in.readLine()) != null) {
				responseString += inputLine;
			}
			in.close();
			System.out.println(responseString);
			if (responseCode == 200) {
				InputSource is = new InputSource(new StringReader(responseString));
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				doc = dBuilder.parse(is);
				XPathFactory xpathFactory = XPathFactory.newInstance();
				XPath xpath = xpathFactory.newXPath();

				XPathExpression expr = xpath.compile("//item");
				NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
				List<AptCodeVO> list = new ArrayList<AptCodeVO>();
				Gson gson = new Gson();
				JsonObject object = new JsonObject();
				for (int i = 0; i < nodeList.getLength(); i++) {
					NodeList child = nodeList.item(i).getChildNodes();

					for (int j = 0; j < child.getLength(); j++) {
						Node node = child.item(j);
						log.info(node.getNodeName() + node.getTextContent());
						if (node.getNodeName().equals("doroJuso")) {
							object.addProperty("doroJuso", node.getTextContent());

						} else if (node.getNodeName().equals("kaptName")) {
							object.addProperty("aptName", node.getTextContent());
						}
					}
				}
				JsonObject tmpObj = new JsonObject();
				tmpObj.add("aptDetailInfo", object);
				return gson.toJson(tmpObj);
			}
			System.out.println(responseString);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "{\"status\": \"false\" ";

	}

	@GetMapping("/location/{roadAddress}")
	public String getPosition(@PathVariable("roadAddress") String roadAddress) {
		final String USER_AGENT = "Mozilla/5.0";
		String url1 = "https://dapi.kakao.com/v2/local/search/address.json?query=";
		String encodeResult;
		try {
			encodeResult = URLEncoder.encode(roadAddress, "utf-8");
			URL targetUrl = new URL(url1 + encodeResult);
			HttpURLConnection con = (HttpURLConnection) targetUrl.openConnection();
			con.setRequestProperty("Authorization", ApiKeys.getKakaoMapApiKey());
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", USER_AGENT);
			DocumentBuilder builder;
			Document doc = null;
			int responseCode = con.getResponseCode();
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			String responseString = new String();

			while ((inputLine = in.readLine()) != null) {
				responseString += inputLine;
			}

			return responseString;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{\"status\" : \"false\"}";
		}
	}

	@PostMapping(value = "/aptInsert", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String insertApt(@RequestBody AptVO apt) {
		int result = aptMapper.aptCount(apt);
		Gson gson = new Gson();
		JsonObject resultJson = new JsonObject();
		System.out.println(result);
		if (result == 0) {
			aptMapper.insertApt(apt);
			resultJson.addProperty("status", "true");
		} else if (result == 1) {
			resultJson.addProperty("status", "exist");
		} else {
			resultJson.addProperty("status", "error");
		}
		return gson.toJson(resultJson);
	}

	@PostMapping(value = "/showAptList", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody String aptSearchWithName(@RequestBody Map<String, Object> aptNameMap) {
		Gson gson = new Gson();

		JsonArray array = new JsonArray();
		if (aptNameMap == null) {
			JsonObject obj = new JsonObject();
			obj.addProperty("status", "invaild_input");
			return gson.toJson(obj);
		} else {
			String aptName = (String) aptNameMap.get("aptName");
			System.out.println("%" + aptName + "%");
			List<AptVO> aptList = (List<AptVO>) aptMapper.searchWithKeyword("%" + aptName + "%");
			System.out.println(aptList.size());
			JsonObject jsonObj = new JsonObject();
			if(aptList.size() == 0) {
				jsonObj.addProperty("status", "no_value");
			}else {
				jsonObj.addProperty("status", "success");
			}
			
			for (AptVO apt : aptList) {
				JsonObject obj = new JsonObject();
				obj.addProperty("aptName", apt.getAptName());
				obj.addProperty("aptSeq", apt.getAptSeq());
				obj.addProperty("aptLocation", apt.getLocation());
				array.add(obj);
			}
			jsonObj.add("aptList", array);
			return gson.toJson(jsonObj);
		}
	}
}