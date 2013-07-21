package com.baidu.scan.model;

public class Cache {

	private String uuid;
	private boolean radio;
	private String mark;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public boolean isRadio() {
		return radio;
	}
	public void setRadio(boolean radio) {
		this.radio = radio;
	}
	@Override
	public String toString() {
		return "Cache [uuid=" + uuid + ", radio=" + radio + ", mark=" + mark
				+ "]";
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public String getType() {
		// TODO Auto-generated method stub
		return uuid.substring(uuid.lastIndexOf("."));
	}
}
