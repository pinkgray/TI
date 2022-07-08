package com.kh.ti.adminCallCenter.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.adminCallCenter.model.vo.BoardAttachment;
import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.travelRequest.model.vo.TravelRequest;

@Repository
public class AdminCallCenterDaoImpl implements AdminCallCenterDao{

	//공지글 인서트
	@Override
	public int insertNotice(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("CallCenter.insertNotice", b);
	}

	//공지글 이미지 인서트
	@Override
	public int insertNoticeImg(SqlSessionTemplate sqlSession, ArrayList<BoardAttachment> attachmentFileList) {
		int result = 0;
		for(int i = 0; i < attachmentFileList.size(); i++) {
			sqlSession.insert("CallCenter.insertNoticeImg", attachmentFileList.get(i));
			result++;
		}
		
		return result;
	}

	//공지글 수 조회
	@Override
	public int getNoticeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CallCenter.getNoticeCount");
	}

	@Override
	public ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("CallCenter.selectNoticeList", null, rowBounds);
	}

	//공지글 상세조회
	@Override
	public Board selectNoticeDetail(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("CallCenter.selectNoticeDetail", boardId);
	}

	//공지글 수정
	@Override
	public int updateNotice(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("CallCenter.updateNotice", b);
	}

	//자주글 수
	@Override
	public int getMoreQuestionCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CallCenter.getMoreQuestionCount");
	}

	//자주글 목록
	@Override
	public ArrayList<Board> selectMoreQuestionList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("CallCenter.selectMoreQuestionList", null, rowBounds);
	}

	//자주글 수정
	@Override
	public int updateMoreQuestion(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("CallCenter.updateMoreQuestion", b);
	}

	//1:1문의글 수
	@Override
	public int getOneToOneCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CallCenter.getOneToOneCount");
	}

	//1:1문의 목록
	@Override
	public ArrayList<Inquiry> selectOneToOneList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("CallCenter.selectOneToOneList", null, rowBounds);
	}

	//1:1문의 상세보기
	@Override
	public Inquiry selectOneInquiry(SqlSessionTemplate sqlSession, int inquiryId) {
		return sqlSession.selectOne("CallCenter.selectOneInquiry", inquiryId);
	}

	//문의 처리
	@Override
	public int updateInquiry(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.update("CallCenter.updateInquiry", inquiry);
	}

	//신고글 수
	@Override
	public int getAdminPenaltyCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Penalty.getAdminPenaltyCount");
	}

	//신고글 목록
	@Override
	public ArrayList<Inquiry> selectAdminPenaltyList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Penalty.selectAdminPenaltyList", null, rowBounds);
	}

	//신고목록 상세조회
	@Override
	public Penalty selectOnePenalty(SqlSessionTemplate sqlSession, int listId) {
		return sqlSession.selectOne("Penalty.selectOnePanelty", listId);
	}

	//신고 승인 조회
	@Override
	public Penalty selectPenaltyOk(SqlSessionTemplate sqlSession, int listId) {
		return sqlSession.selectOne("Penalty.selectPenaltyOk", listId);
	}

	//신고 승인 처리
	@Override
	public int updatePenaltyOk(SqlSessionTemplate sqlSession, Penalty p) {
		return sqlSession.update("Penalty.updatePenaltyOk", p);
	}

	//유저 누적벌점 추가
	@Override
	public int updateMemberPenalty(SqlSessionTemplate sqlSession, Penalty p) {
		return sqlSession.update("Penalty.updateMemberPenalty", p);
	}

	//신고 거절 처리
	@Override
	public int updatePenaltyNo(SqlSessionTemplate sqlSession, Penalty p) {
		return sqlSession.update("Penalty.updatePenaltyNo", p);
	}

	//누적 벌점에 따른 회원상태 변경
	@Override
	public int updateMemberStatus(SqlSessionTemplate sqlSession, Penalty p) {
		return sqlSession.update("Penalty.updateMemberStatus", p);
	}

	//의뢰글 총 수
	@Override
	public int getReqTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Total.getReqTotalCount");
	}

	//의뢰글 목록들
	@Override
	public ArrayList<TravelRequest> selectReqTotalList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Total.selectReqTotalList", null, rowBounds);
	}

	//설계글 수
	@Override
	public int getPlanTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Total.getPlanTotalCount");
	}

	//설계글 목록
	@Override
	public ArrayList<TravelRequest> selectPlanTotalList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Total.selectPlanTotalList", null, rowBounds);
	}

	//일정 수
	@Override
	public int getTrvTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Total.getTrvTotalCount");
	}

	//일정 목록
	@Override
	public ArrayList<TravelRequest> selectTrvTotalList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Total.selectTrvTotalList", null, rowBounds);
	}

	//리뷰 수
	@Override
	public int getReviewTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Total.getReviewTotalCount");
	}

	//리뷰 목록
	@Override
	public ArrayList<TravelRequest> selectReviewTotalList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Total.selectReviewTotalList", null, rowBounds);
	}

	//의뢰글 상세보기
	@Override
	public TravelRequest selectReqDetail(SqlSessionTemplate sqlSession, int reqId) {
		return sqlSession.selectOne("TravelRequest.selectOneRequest", reqId);
	}

	//의뢰글 삭제
	@Override
	public int updateReqDelete(SqlSessionTemplate sqlSession, int reqId) {
		return sqlSession.update("Total.updateReqDelete", reqId);
	}

	//설계글 삭제
	@Override
	public int updatePlanDelete(SqlSessionTemplate sqlSession, int ptcpId) {
		return sqlSession.update("Total.updatePlanDelete", ptcpId);
	}

	//일정글 삭제
	@Override
	public int updateTrvDelete(SqlSessionTemplate sqlSession, int trvId) {
		return sqlSession.update("Total.updateTrvDelete", trvId);
	}

	@Override
	public int updateReviewDelete(SqlSessionTemplate sqlSession, int reviewId) {
		return sqlSession.update("Total.updateReviewDelete", reviewId);
	}

}
