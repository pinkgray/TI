package com.kh.ti.adminCallCenter.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.adminCallCenter.model.vo.BoardAttachment;
import com.kh.ti.adminCallCenter.model.vo.Total;
import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.travelRequest.model.vo.TravelRequest;

public interface AdminCallCenterDao {

	int insertNotice(SqlSessionTemplate sqlSession, Board b);

	int insertNoticeImg(SqlSessionTemplate sqlSession, ArrayList<BoardAttachment> attachmentFileList);

	int getNoticeCount(SqlSessionTemplate sqlSession);

	ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi);

	Board selectNoticeDetail(SqlSessionTemplate sqlSession, int boardId);

	int updateNotice(SqlSessionTemplate sqlSession, Board b);

	int getMoreQuestionCount(SqlSessionTemplate sqlSession);

	ArrayList<Board> selectMoreQuestionList(SqlSessionTemplate sqlSession, PageInfo pi);

	int updateMoreQuestion(SqlSessionTemplate sqlSession, Board b);

	Inquiry selectOneInquiry(SqlSessionTemplate sqlSession, int inquiryId);

	int getOneToOneCount(SqlSessionTemplate sqlSession);

	ArrayList<Inquiry> selectOneToOneList(SqlSessionTemplate sqlSession, PageInfo pi);

	int updateInquiry(SqlSessionTemplate sqlSession, Inquiry inquiry);

	int getAdminPenaltyCount(SqlSessionTemplate sqlSession);

	ArrayList<Inquiry> selectAdminPenaltyList(SqlSessionTemplate sqlSession, PageInfo pi);

	Penalty selectOnePenalty(SqlSessionTemplate sqlSession, int listId);

	Penalty selectPenaltyOk(SqlSessionTemplate sqlSession, int listId);

	int updatePenaltyOk(SqlSessionTemplate sqlSession, Penalty p);

	int updateMemberPenalty(SqlSessionTemplate sqlSession, Penalty p);

	int updatePenaltyNo(SqlSessionTemplate sqlSession, Penalty p);

	int updateMemberStatus(SqlSessionTemplate sqlSession, Penalty p);

	int getReqTotalCount(SqlSessionTemplate sqlSession);

	ArrayList<TravelRequest> selectReqTotalList(SqlSessionTemplate sqlSession, PageInfo pi);

	int getPlanTotalCount(SqlSessionTemplate sqlSession);

	ArrayList<TravelRequest> selectPlanTotalList(SqlSessionTemplate sqlSession, PageInfo pi);

	int getTrvTotalCount(SqlSessionTemplate sqlSession);

	ArrayList<TravelRequest> selectTrvTotalList(SqlSessionTemplate sqlSession, PageInfo pi);

	int getReviewTotalCount(SqlSessionTemplate sqlSession);

	ArrayList<TravelRequest> selectReviewTotalList(SqlSessionTemplate sqlSession, PageInfo pi);

	TravelRequest selectReqDetail(SqlSessionTemplate sqlSession, int reqId);

	int updateReqDelete(SqlSessionTemplate sqlSession, int reqId);

	int updatePlanDelete(SqlSessionTemplate sqlSession, int ptcpId);

	int updateTrvDelete(SqlSessionTemplate sqlSession, int trvId);

	int updateReviewDelete(SqlSessionTemplate sqlSession, int reviewId);

}
