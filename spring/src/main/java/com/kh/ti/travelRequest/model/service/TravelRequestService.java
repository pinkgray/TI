package com.kh.ti.travelRequest.model.service;

import java.util.ArrayList;

import com.kh.ti.common.PageInfo;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

public interface TravelRequestService {

	int insertRequest(TravelRequest tr);

	int getListCount();

	ArrayList<TravelRequest> selectRequestList(PageInfo pi);

	TravelRequest selectOneRequest(int reqNum);

	//ArrayList<TravelRequestPlan> selectOneRequestPlan(int code);

	ArrayList<TravelRequestPlan> selectOneRequestPlan(int ptcpId);
}
