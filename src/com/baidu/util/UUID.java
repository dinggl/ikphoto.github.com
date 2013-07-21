package com.baidu.util;

public class UUID {
	private static int uuid =0 ;
	public static synchronized int getUUID()
	{
		uuid++;
		return uuid;
	}
}
