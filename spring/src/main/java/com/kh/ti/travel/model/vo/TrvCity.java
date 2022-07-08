package com.kh.ti.travel.model.vo;

public class TrvCity {
	
	private int cityId;
	private int trvId;
	private String cityNameKo;
	private String cityNameEn;
	private int countryId;
	private String countryNameKo;
	private String countryNameEn;
	private String currencyUnit;
	
	public TrvCity() {}

	public TrvCity(int cityId, int trvId, String cityNameKo, String cityNameEn, int countryId, String countryNameKo,
			String countryNameEn, String currencyUnit) {
		super();
		this.cityId = cityId;
		this.trvId = trvId;
		this.cityNameKo = cityNameKo;
		this.cityNameEn = cityNameEn;
		this.countryId = countryId;
		this.countryNameKo = countryNameKo;
		this.countryNameEn = countryNameEn;
		this.currencyUnit = currencyUnit;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public String getCityNameKo() {
		return cityNameKo;
	}

	public void setCityNameKo(String cityNameKo) {
		this.cityNameKo = cityNameKo;
	}

	public String getCityNameEn() {
		return cityNameEn;
	}

	public void setCityNameEn(String cityNameEn) {
		this.cityNameEn = cityNameEn;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public String getCountryNameKo() {
		return countryNameKo;
	}

	public void setCountryNameKo(String countryNameKo) {
		this.countryNameKo = countryNameKo;
	}

	public String getCountryNameEn() {
		return countryNameEn;
	}

	public void setCountryNameEn(String countryNameEn) {
		this.countryNameEn = countryNameEn;
	}

	public String getCurrencyUnit() {
		return currencyUnit;
	}

	public void setCurrencyUnit(String currencyUnit) {
		this.currencyUnit = currencyUnit;
	}

	@Override
	public String toString() {
		return "TrvCity [cityId=" + cityId + ", trvId=" + trvId + ", cityNameKo=" + cityNameKo + ", cityNameEn="
				+ cityNameEn + ", countryId=" + countryId + ", countryNameKo=" + countryNameKo + ", countryNameEn="
				+ countryNameEn + ", currencyUnit=" + currencyUnit + "]";
	}

	
	
	

}
