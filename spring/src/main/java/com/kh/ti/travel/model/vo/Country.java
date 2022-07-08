package com.kh.ti.travel.model.vo;

public class Country implements java.io.Serializable{

	private int countryId;
	private String continentName;
	private String countryNameKo;
	private String countryNameEn;
	private String currencyUnit;
	
	public Country() {}
	
	public Country(int countryId, String continentName, String countryNameKo, String countryNameEn,
			String currencyUnit) {
		super();
		this.countryId = countryId;
		this.continentName = continentName;
		this.countryNameKo = countryNameKo;
		this.countryNameEn = countryNameEn;
		this.currencyUnit = currencyUnit;
	}
	public int getCountryId() {
		return countryId;
	}
	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}
	public String getContinentName() {
		return continentName;
	}
	public void setContinentName(String continentName) {
		this.continentName = continentName;
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
		return "Country [countryId=" + countryId + ", continentName=" + continentName + ", countryNameKo="
				+ countryNameKo + ", countryNameEn=" + countryNameEn + ", currencyUnit=" + currencyUnit + "]";
	}
	
	
}
