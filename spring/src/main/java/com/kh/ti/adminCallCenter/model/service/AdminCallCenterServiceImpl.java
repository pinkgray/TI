package com.kh.ti.adminCallCenter.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.kh.ti.adminCallCenter.model.dao.AdminCallCenterDao;
import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.adminCallCenter.model.vo.BoardAttachment;
import com.kh.ti.adminCallCenter.model.vo.Total;
import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.penalty.model.dao.PenaltyDao;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.travelRequest.model.vo.TravelRequest;


@Service
public class AdminCallCenterServiceImpl implements AdminCallCenterService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private AdminCallCenterDao ccd;
	@Autowired
	private DataSourceTransactionManager transactionManager;

	//공지사항 인서트
	@Override
	public int insertNotice(Board b, ArrayList<BoardAttachment> attachmentFileList) {
		int result = 0;
		
		//공지글 인서트
		int result1 = ccd.insertNotice(sqlSession, b);
		if(result1 > 0) {
			result = 1;
		}
		//공지글 이미지 인서트
		if(attachmentFileList.size() > 0) {
			int result2 = ccd.insertNoticeImg(sqlSession, attachmentFileList);
			
			if(result2 == attachmentFileList.size()) {
				result = 1;
			} else {
				result = 0;
			}			
		}
		return result;
	}

	//공지글 수 조회
	@Override
	public int getNoticeCount() {
		return ccd.getNoticeCount(sqlSession);
	}

	//공지글 목록 조회
	@Override
	public ArrayList<Board> selectNoticeList(PageInfo pi) {
		return ccd.selectNoticeList(sqlSession, pi);
	}

	//공지글 상세조회
	@Override
	public Board selectOneNotice(int boardId) {
		return ccd.selectNoticeDetail(sqlSession, boardId);
	}

	//공지글 수정
	@Override
	public int updateNotice(Board b) {
		return ccd.updateNotice(sqlSession, b);
	}

	//자주글 수
	@Override
	public int getMoreQuestionCount() {
		return ccd.getMoreQuestionCount(sqlSession);
	}

	//자주글 목록
	@Override
	public ArrayList<Board> selectMoreQuestionList(PageInfo pi) {
		return ccd.selectMoreQuestionList(sqlSession, pi);
	}

	//자주글 수정
	@Override
	public int updateMoreQuestion(Board b) {
		return ccd.updateMoreQuestion(sqlSession, b);
	}

	//1:1문의 수
	@Override
	public int getOneToOneCount() {
		return ccd.getOneToOneCount(sqlSession);
	}

	//1:1문의 목록 조회
	@Override
	public ArrayList<Inquiry> selectOneToOneList(PageInfo pi) {
		return ccd.selectOneToOneList(sqlSession, pi);
	}

	//1:1문의 상세보기
	@Override
	public Inquiry selectOneInquiry(int inquiryId) {
		return ccd.selectOneInquiry(sqlSession, inquiryId);
	}

	//문의 처리
	@Override
	public int updateInquiry(Inquiry inquiry) {
		return ccd.updateInquiry(sqlSession, inquiry);
	}

	//신고글 수
	@Override
	public int getAdminPenaltyCount() {
		return ccd.getAdminPenaltyCount(sqlSession);
	}

	//신고목록 조회
	@Override
	public ArrayList<Inquiry> selectAdminPenaltyList(PageInfo pi) {
		return ccd.selectAdminPenaltyList(sqlSession, pi);
	}

	//신고글 상세보기
	@Override
	public Penalty selectOnePenalty(int listId) {
		return ccd.selectOnePenalty(sqlSession, listId);
	}

	//신고승인 조회
	@Override
	public Penalty selectPenaltyOk(int listId) {
		return ccd.selectPenaltyOk(sqlSession, listId);
	}

	//신고 승인 처리
	@Override
	public int updatePenaltyOk(Penalty p) {
		int result = 0;
		
		int result1 = ccd.updatePenaltyOk(sqlSession, p);
		
		if(result1 > 0) {
			int result2 = ccd.updateMemberPenalty(sqlSession, p);
			if(result2 > 0) {
				result = 1;
			} else {
				result = 0;
			}
		}
		int result2 = ccd.updateMemberStatus(sqlSession, p);
		
		return result;
	}

	//신고 거절 처리
	@Override
	public int updatePenaltyNo(Penalty p) {
		return ccd.updatePenaltyNo(sqlSession, p);
	}

	//의뢰글 총 수
	@Override
	public int getReqTotalCount() {
		return ccd.getReqTotalCount(sqlSession);
	}

	//의뢰글 목록
	@Override
	public ArrayList<TravelRequest> selectReqTotalList(PageInfo pi) {
		return ccd.selectReqTotalList(sqlSession, pi);
	}

	//설계글 수
	@Override
	public int getPlanTotalCount() {
		return ccd.getPlanTotalCount(sqlSession);
	}

	//설계글 목록
	@Override
	public ArrayList<TravelRequest> selectPlanTotalList(PageInfo pi) {
		return ccd.selectPlanTotalList(sqlSession, pi);
	}

	//일정 수
	@Override
	public int getTrvTotalCount() {
		return ccd.getTrvTotalCount(sqlSession);
	}

	//일정 목록
	@Override
	public ArrayList<TravelRequest> selectTrvTotalList(PageInfo pi) {
		return ccd.selectTrvTotalList(sqlSession, pi);
	}

	//리뷰 수
	@Override
	public int getReviewTotalCount() {
		return ccd.getReviewTotalCount(sqlSession);
	}

	//리뷰 목록 조회
	@Override
	public ArrayList<TravelRequest> selectReviewTotalList(PageInfo pi) {
		return ccd.selectReviewTotalList(sqlSession, pi);
	}

	//의뢰글 상세보기
	@Override
	public TravelRequest selectReqDetail(int reqId) {
		return ccd.selectReqDetail(sqlSession, reqId);
	}

	//의뢰글 삭제
	@Override
	public int updateReqDelete(int reqId) {
		return ccd.updateReqDelete(sqlSession, reqId);
	}

	//설계글 삭제
	@Override
	public int updatePlanDelete(int ptcpId) {
		return ccd.updatePlanDelete(sqlSession, ptcpId);
	}

	//일정 삭제
	@Override
	public int updateTrvDelete(int trvId) {
		return ccd.updateTrvDelete(sqlSession, trvId);
	}

	//리뷰 삭제
	@Override
	public int updateReviewDelete(int reviewId) {
		return ccd.updateReviewDelete(sqlSession, reviewId);
	}
}
