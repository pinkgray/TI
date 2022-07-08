package com.kh.ti.travel.model.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;



public class Travel implements java.io.Serializable {
	
	private int trvId;
	private String trvTitle;
	private Date startDate;
	private Date endDate;
	private int compNumber;
	private int budget;
	private Date openDate;
	private Date modifyDate;
	private Date completeDate;
	private String status;
	private int memberId;
	private String userName;
	private int[] trvCities;
	private int[] trvComps;
	private int[] trvTags;
	private int trvRef;
	private ArrayList<TrvCity> trvCityList;
	private ArrayList<TrvTag> trvTagList;
	private SchFile mainImage;
	
	public Travel() {}

	public Travel(int trvId, String trvTitle, Date startDate, Date endDate, int compNumber, int budget, Date openDate,
			Date modifyDate, Date completeDate, String status, int memberId, String userName, int[] trvCities,
			int[] trvComps, int[] trvTags, int trvRef, ArrayList<TrvCity> trvCityList, ArrayList<TrvTag> trvTagList,
			SchFile mainImage) {
		super();
		this.trvId = trvId;
		this.trvTitle = trvTitle;
		this.startDate = startDate;
		this.endDate = endDate;
		this.compNumber = compNumber;
		this.budget = budget;
		this.openDate = openDate;
		this.modifyDate = modifyDate;
		this.completeDate = completeDate;
		this.status = status;
		this.memberId = memberId;
		this.userName = userName;
		this.trvCities = trvCities;
		this.trvComps = trvComps;
		this.trvTags = trvTags;
		this.trvRef = trvRef;
		this.trvCityList = trvCityList;
		this.trvTagList = trvTagList;
		this.mainImage = mainImage;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public String getTrvTitle() {
		return trvTitle;
	}

	public void setTrvTitle(String trvTitle) {
		this.trvTitle = trvTitle;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getCompNumber() {
		return compNumber;
	}

	public void setCompNumber(int compNumber) {
		this.compNumber = compNumber;
	}

	public int getBudget() {
		return budget;
	}

	public void setBudget(int budget) {
		this.budget = budget;
	}

	public Date getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Date getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int[] getTrvCities() {
		return trvCities;
	}

	public void setTrvCities(int[] trvCities) {
		this.trvCities = trvCities;
	}

	public int[] getTrvComps() {
		return trvComps;
	}

	public void setTrvComps(int[] trvComps) {
		this.trvComps = trvComps;
	}

	public int[] getTrvTags() {
		return trvTags;
	}

	public void setTrvTags(int[] trvTags) {
		this.trvTags = trvTags;
	}

	public int getTrvRef() {
		return trvRef;
	}

	public void setTrvRef(int trvRef) {
		this.trvRef = trvRef;
	}

	public ArrayList<TrvCity> getTrvCityList() {
		return trvCityList;
	}

	public void setTrvCityList(ArrayList<TrvCity> trvCityList) {
		this.trvCityList = trvCityList;
	}

	public ArrayList<TrvTag> getTrvTagList() {
		return trvTagList;
	}

	public void setTrvTagList(ArrayList<TrvTag> trvTagList) {
		this.trvTagList = trvTagList;
	}

	public SchFile getMainImage() {
		return mainImage;
	}

	public void setMainImage(SchFile mainImage) {
		this.mainImage = mainImage;
	}

	@Override
	public String toString() {
		return "Travel [trvId=" + trvId + ", trvTitle=" + trvTitle + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", compNumber=" + compNumber + ", budget=" + budget + ", openDate=" + openDate + ", modifyDate="
				+ modifyDate + ", completeDate=" + completeDate + ", status=" + status + ", memberId=" + memberId
				+ ", userName=" + userName + ", trvCities=" + Arrays.toString(trvCities) + ", trvComps="
				+ Arrays.toString(trvComps) + ", trvTags=" + Arrays.toString(trvTags) + ", trvRef=" + trvRef
				+ ", trvCityList=" + trvCityList + ", trvTagList=" + trvTagList + ", mainImage=" + mainImage + "]";
	}

	

	
	

	
	
	
	

}
