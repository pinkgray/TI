package com.kh.ti.point.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.point.model.vo.Payment;
import com.kh.ti.point.model.vo.Proceeds;
import com.kh.ti.point.model.vo.Rebate;
import com.kh.ti.point.model.vo.Refund;
import com.kh.ti.point.model.vo.ReservePoint;
import com.kh.ti.point.model.vo.SearchPoint;
import com.kh.ti.point.model.vo.UsePoint;

public interface PointDao {

	//포인트 충전
	int insertPay(SqlSessionTemplate sqlSession, Payment pay);
	//포인트 충전 리스트 전체 카운터
	int getChargeListCount(SqlSessionTemplate sqlSession, Payment charge);
	//포인트 지급 리스트 전체 카운터
	int getReceiveListCount(SqlSessionTemplate sqlSession, ReservePoint reserve);
	//포인트 사용 리스트 전체 카운터
	int getUseListCount(SqlSessionTemplate sqlSession, UsePoint use);
	//포인트 충전리스트 전체 조회
	ArrayList selectChargeList(SqlSessionTemplate sqlSession, PageInfo chPi, Payment charge);
	//포인트 지급리스트 전체 조회
	ArrayList<ReservePoint> selectReceiveList(SqlSessionTemplate sqlSession, PageInfo rePi, ReservePoint reserve);
	//포인트 사용리스트 전체 조회
	ArrayList<UsePoint> selectUseList(SqlSessionTemplate sqlSession, PageInfo usPi, UsePoint use);
	//포인트 자동으로 적립하기
	int insertReservePoint(SqlSessionTemplate sqlSession, ReservePoint rp);
	//성공시 멤버 누적포인트 증가
	int updateUserPointAuto(SqlSessionTemplate sqlSession, ReservePoint rp);
	//포인트 환불신청하기-> 환불 내역에 인서트
	int insertRefund(SqlSessionTemplate sqlSession, Refund refund);
	//해당 reviewId로 trvId 조회해오기
	int selectOneTrv(SqlSessionTemplate sqlSession, ReservePoint rp);
	//Member 테이블의 userPoint조회해오기
	int selectUserPoint(SqlSessionTemplate sqlSession, int memberId);
	//Member 테이블의 userPoint조회해오기
	int selectUserProceeds(SqlSessionTemplate sqlSession, int memberId);
	//포인트 사용 후 포인트 사용내역에 insert
	int insertPointUse(SqlSessionTemplate sqlSession, UsePoint userPoint);
	//포인트 충전시 멤버 테이블의 누적포인트 증가
	int updateUserPoint(SqlSessionTemplate sqlSession, Payment pay);
	//수익금 여행글에 따른 memberId 찾기
	int selectReceiverTrvMemberId(SqlSessionTemplate sqlSession, int trvId);
	//수익금 의뢰글에 따른 memberId 찾기
	int selectReceiverRequestMemberId(SqlSessionTemplate sqlSession, int ptcpId);
	//성공시 수익금발생내역에 인서트
	int insertReceiverProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard);
	//판매자의 기존 수익금 내역이 존재할 시 update만
	int updateReceiverProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard);
	//성공시 member 테이블의 누적 포인트 차감(memberId)
	int updateUserDeductionPoint(SqlSessionTemplate sqlSession, UsePoint userPoint);
	//성공시 member 테이블의 누적 수익금 추가
	int updateUserIncreaseProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard);
	//수익금 달성내역 전체 리스트 카운트
	int getProceedsListCount(SqlSessionTemplate sqlSession, Proceeds proceeds);
	//수익금 달성내역 가져오기
	ArrayList<Proceeds> selectAllProceeds(SqlSessionTemplate sqlSession, PageInfo proPi, Proceeds proceeds);
	//누적수익금을 위한 기존 수익금 조회
	Proceeds selectOneProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard);
	//환급 신청내역 전체 리스트 카운트
	int getRebateListCount(SqlSessionTemplate sqlSession, Rebate rebate);
	//환급 신청내역 전체 리스트 조회
	ArrayList<Rebate> selectAllRebate(SqlSessionTemplate sqlSession, Rebate rebate, PageInfo rebatePi);
	//환불 신청시
	int insertRebate(SqlSessionTemplate sqlSession, Rebate rebate);
	//신청 성공시 수익금 차감
	int updateDeductionRebate(SqlSessionTemplate sqlSession, Rebate rebate);
	//--------------------------------------------------------관리자
	//관리자  총 결제 내역 전체 조회, 검색조회
	ArrayList<Payment> selectAdPayList(SqlSessionTemplate sqlSession,PageInfo adPayPi, SearchPoint sp);
	//관리자 - 총 결제 내역 리스트 카운트
	int getAdPaymentListCount(SqlSessionTemplate sqlSession);
	//세션에 저장하기 위해 구매한 사람의 포인트를 가져온다.
	int getUseMemberPoint(SqlSessionTemplate sqlSession, int memberId);
	//세션에 저장하기 위해 판 사람의 수익금을 가져온다.
	int getRecevieMemberProceeds(SqlSessionTemplate sqlSession, int memberId);
	//관리자 - 결제내역 검색 리스트 카운트
	int getAdPaySearchListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//관리자 - 포인트내역 검색 리스트 카운트
	int getAdPointListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//관리자 - 포인트 내역 전체 조회, 검색 조회 
	ArrayList<Payment> selectAdPointList(SqlSessionTemplate sqlSession, PageInfo adPointPi, SearchPoint sp);
	//관리자 - 환불 내역 리스트 카운트
	int getAdRefundListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//관리자 - 환불 내역 전체 조회, 검색 조회 
	ArrayList<Payment> selectAdRefundList(SqlSessionTemplate sqlSession, PageInfo adRefundPi, SearchPoint sp);
	//관리자 - 환불 상태 바꿔주기
	int updateRefund(SqlSessionTemplate sqlSession, Refund refund);
	//관리자 - 업데이트 된 환불 내역 들고오기
	Refund selectOneRefund(SqlSessionTemplate sqlSession, Refund refund);
	//관리자 - 환불 상태 성공시 산 사람의 userPoint 업데이트
	int updateUserPointRefund(SqlSessionTemplate sqlSession, Refund updatedRefund);
	//관리자 - 판 사람의 아이디 조회 -trvId 이용
	Proceeds selectMemberIdTrv(SqlSessionTemplate sqlSession, Refund updatedRefund);
	//관리자 - 판 사람의 아이디 조회 -planId 이용
	Proceeds selectMemberIdRequest(SqlSessionTemplate sqlSession, Refund updatedRefund);
	//관리자 - 판 사람의 userProceeds 차감
	int updateUserProceedsRefund(SqlSessionTemplate sqlSession, Proceeds proceeds);
	//판매자의 참여번호를 조회해와야 함
	int selectOnePtcp(SqlSessionTemplate sqlSession, int requestId);
	//차감된 userPoint 찾기
	int selectOnePoint(SqlSessionTemplate sqlSession, int memberId);
	//관리자 - 수익금 리스트 카운트
	int getAdProceedsListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//관리자 - 수익금 조회
	ArrayList<Proceeds> selectAdProceedsList(SqlSessionTemplate sqlSession, PageInfo adProceedsPi, SearchPoint sp);
	//명소리뷰코드로 명소코드 가져오기
	int selectSpotId(SqlSessionTemplate sqlSession, int spotReviewId);
	//관리자 - 환급 내역 리스트 카운트
	int getAdRebateListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//관리자 - 환급 내역 조회
	ArrayList<Proceeds> selectAdRebateList(SqlSessionTemplate sqlSession, PageInfo adRebatePi, SearchPoint sp);
	//관리자 - 환급 상태 1개변경
	int updateAdRebate(SqlSessionTemplate sqlSession, int refundId);
	//관리자 - 환급 상태 여러개변경
	int updateAdRebates(SqlSessionTemplate sqlSession, int refundId);
	//관리자 - 미지급 내역 다운로드
	ArrayList<HashMap> downRebates(SqlSessionTemplate sqlSession, int rebateStatus);
	//일정리뷰 코드 이용하여 trvId조회
	int selectTrvId(SqlSessionTemplate sqlSession, int reviewId);
	//사용자 - 환급신청 내역 월 검색 리스트 카운트
	int selectOneRebateListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//사용자 - 환급신청 내역 월 검색 조회
	ArrayList<Rebate> selectOneRebateList(SqlSessionTemplate sqlSession, PageInfo rebatePi, SearchPoint sp);
	//사용자 - 수익달성 내역 월 검색 리스트 카운트
	int selectOneProceedsListCount(SqlSessionTemplate sqlSession, SearchPoint sp);
	//사용자 - 수익달성 내역 월 검색 조회
	ArrayList<Proceeds> selectOneProceedsList(SqlSessionTemplate sqlSession, PageInfo proPi, SearchPoint sp);
}
