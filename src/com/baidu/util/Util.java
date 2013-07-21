package com.baidu.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.Gson;

public class Util {
	public static Gson gson = new Gson();
	
	public static String parseDate2Name(Date date)
	{
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
	
	public static String Entity2Json(Object obj)
	{
		return gson.toJson(obj);
	}
	

}
