package com.kh.ti.travel.model.vo;


public class City implements java.io.Serializable{
	
	private int cityId;
	private String cityNameKo;
	private String cityContent;
	private int countryId;
	private String cityNameEn;
	
	public City() {}

	public City(int cityId, String cityNameKo, String cityContent, int countryId, String cityNameEn) {
		super();
		this.cityId = cityId;
		this.cityNameKo = cityNameKo;
		this.cityContent = cityContent;
		this.countryId = countryId;
		this.cityNameEn = cityNameEn;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getCityNameKo() {
		return cityNameKo;
	}

	public void setCityNameKo(String cityNameKo) {
		this.cityNameKo = cityNameKo;
	}

	public String getCityContent() {
		return cityContent;
	}

	public void setCityContent(String cityContent) {
		this.cityContent = cityContent;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public String getCityNameEn() {
		return cityNameEn;
	}

	public void setCityNameEn(String cityNameEn) {
		this.cityNameEn = cityNameEn;
	}

	@Override
	public String toString() {
		return "City [cityId=" + cityId + ", cityNameKo=" + cityNameKo + ", cityContent=" + cityContent + ", countryId="
				+ countryId + ", cityNameEn=" + cityNameEn + "]";
	}
	
	
	
}
