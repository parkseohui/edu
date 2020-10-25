package org.apartment.security;

public class ApiKeys {
	static private String aptListKey = "W268QEUf15cVqsKsF1vSki2nFxMgPpX9bufUd%2FgiBazwrY8LNRWemymP2U9GQvIoWbkLqRSYdgXzP6AJIbrthA%3D%3D";
	static private String aptDetailKey = "W268QEUf15cVqsKsF1vSki2nFxMgPpX9bufUd%2FgiBazwrY8LNRWemymP2U9GQvIoWbkLqRSYdgXzP6AJIbrthA%3D%3D";
	static private String mapApiKey="012e53d65597e9d0766e69ea0332b43b";
	static private String kakaoMapApiKey = "KakaoAK 15fb0aeb5a335f299ee0ec4fbaf97467";
	
	public static String getKakaoMapApiKey() {
		return kakaoMapApiKey;
	}
	public static void setKakaoMapApiKey(String kakaoMapApiKey) {
		ApiKeys.kakaoMapApiKey = kakaoMapApiKey;
	}
	public static String getAptListKey() {
		return aptListKey;
	}
	public static void setAptListKey(String aptListKey) {
		ApiKeys.aptListKey = aptListKey;
	}
	public static String getMapApiKey() {
		return mapApiKey;
	}
	public static void setMapApiKey(String mapApiKey) {
		ApiKeys.mapApiKey = mapApiKey;
	}
	public static String getAptDetailKey() {
		return aptDetailKey;
	}
	public static void setAptDetailKey(String aptDetailKey) {
		ApiKeys.aptDetailKey = aptDetailKey;
	}
	
}