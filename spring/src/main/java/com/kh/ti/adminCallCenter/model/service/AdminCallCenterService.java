package com.kh.ti.adminCallCenter.model.service;

import java.util.ArrayList;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.adminCallCenter.model.vo.BoardAttachment;
import com.kh.ti.adminCallCenter.model.vo.Total;
import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.travelRequest.model.vo.TravelRequest;

public interface AdminCallCenterService {

	int insertNotice(Board b, ArrayList<BoardAttachment> attachmentFileList);

	int getNoticeCount();

	ArrayList<Board> selectNoticeList(PageInfo pi);

	Board selectOneNotice(int boardId);

	int updateNotice(Board b);

	int getMoreQuestionCount();

	ArrayList<Board> selectMoreQuestionList(PageInfo pi);

	int updateMoreQuestion(Board b);

	Inquiry selectOneInquiry(int inquiryId);

	int getOneToOneCount();

	ArrayList<Inquiry> selectOneToOneList(PageInfo pi);

	int updateInquiry(Inquiry inquiry);

	int getAdminPenaltyCount();

	ArrayList<Inquiry> selectAdminPenaltyList(PageInfo pi);

	Penalty selectOnePenalty(int listId);

	Penalty selectPenaltyOk(int listId);

	int updatePenaltyOk(Penalty p);

	int updatePenaltyNo(Penalty p);

	int getReqTotalCount();

	ArrayList<TravelRequest> selectReqTotalList(PageInfo pi);

	int getPlanTotalCount();

	ArrayList<TravelRequest> selectPlanTotalList(PageInfo pi);

	int getTrvTotalCount();

	ArrayList<TravelRequest> selectTrvTotalList(PageInfo pi);

	int getReviewTotalCount();

	ArrayList<TravelRequest> selectReviewTotalList(PageInfo pi);

	TravelRequest selectReqDetail(int reqId);

	int updateReqDelete(int reqId);

	int updatePlanDelete(int ptcpId);

	int updateTrvDelete(int trvId);

	int updateReviewDelete(int reviewId);


}
