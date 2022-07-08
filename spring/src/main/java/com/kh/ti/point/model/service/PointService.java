package com.kh.ti.point.model.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.point.model.vo.Payment;
import com.kh.ti.point.model.vo.Proceeds;
import com.kh.ti.point.model.vo.Rebate;
import com.kh.ti.point.model.vo.Refund;
import com.kh.ti.point.model.vo.ReservePoint;
import com.kh.ti.point.model.vo.SearchPoint;
import com.kh.ti.point.model.vo.UsePoint;

public interface PointService {

	//포인트 충전
	int insertPay(Payment pay);
	//포인트 충전 리스트 전체 카운터
	int getChargeListCount(Payment charge);
	//포인트 지급 리스트 전체 카운터
	int getReceiveListCount(ReservePoint reserve);
	//포인트 사용 리스트 전체 카운터
	int getUseListCount(UsePoint use);
	//포인트 충전리스트 전체 조회
	ArrayList selectChargeList(PageInfo chPi, Payment charge);
	//포인트 지급리스트 전체 조회
	ArrayList<ReservePoint> selectReceiveList(PageInfo rePi, ReservePoint reserve);
	//포인트 사용리스트 전체 조회
	ArrayList<UsePoint> selectUseList(PageInfo usPi, UsePoint use);
	//포인트 자동으로 적립하기
	int insertReservePoint(ReservePoint rp);
	//성공시 멤버 누적포인트 증가
	int updateUserPointAuto(ReservePoint rp);
	//포인트 환불신청하기-> 환불 내역에 인서트
	int insertRefund(Refund refund);
	//해당 reviewId로 trvId 조회해오기
	int selectOneTrv(ReservePoint rp);
	//Member 테이블의 userPoint조회해오기
	int selectUserPoint(int memberId);
	//Member 테이블의 userProceeds조회해오기
	int selectUserProceeds(int memberId);
	//포인트 사용 후 포인트 사용내역에 insert
	int insertPointUse(UsePoint userPoint);
	//포인트 충전시 멤버 테이블의 누적포인트 증가
	int updateUserPoint(Payment pay);
	//수익금 여행글에 따른 memberId 찾기
	int selectReceiverTrvMemberId(int trvId);
	//수익금 의뢰글에 따른 memberId 찾기
	int selectReceiverRequestMemberId(int ptcpId);
	//성공시 수익금발생내역에 인서트
	int insertReceiverProceeds(Proceeds receiverBoard);
	//판매자의 기존 수익금 내역이 존재할 시 update만
	int updateReceiverProceeds(Proceeds receiverBoard);
	//성공시 member 테이블의 누적 포인트 차감(memberId)
	int updateUserDeductionPoint(UsePoint userPoint);
	//성공시 member 테이블의 누적 수익금 추가
	int updateUserIncreaseProceeds(Proceeds receiverBoard);
	//수익금 달성내역 전체 리스트 카운트
	int getProceedsListCount(Proceeds proceeds);
	//수익금 달성내역 가져오기
	ArrayList<Proceeds> selectAllProceeds(PageInfo proPi, Proceeds proceeds);
	//누적수익금을 위한 기존 수익금 조회
	Proceeds selectOneProceeds(Proceeds receiverBoard);
	//환급 신청내역 전체 리스트 카운트
	int getRebateListCount(Rebate rebate);
	//환급 신청내역 전체 리스트 조회
	ArrayList<Rebate> selectAllRebate(PageInfo rebatePi, Rebate rebate);
	//환급 신청시
	int insertRebate(Rebate rebate);
	//신청 성공시 수익금 차감
	int updateDeductionRebate(Rebate rebate);
	//--------------------------------------------------------관리자
	//관리자  총 결제 내역 전체 조회, 검색조회
	ArrayList<Payment> selectAdPayList(PageInfo adPayPi, SearchPoint sp);
	//관리자 - 총 결제 내역 리스트 카운트
	int getAdPaymentListCount();
	//세션에 저장하기 위해 구매한 사람의 포인트를 가져온다.
	int getUseMemberPoint(int memberId);
	//세션에 저장하기 위해 판 사람의 수익금을 가져온다.
	int getRecevieMemberProceeds(int memberId);
	//관리자 - 결제내역 검색 리스트 카운트
	int getAdPaySearchListCount(SearchPoint sp);
	//관리자 - 포인트내역 전체 리스트 카운트
	int getAdPointListCount(SearchPoint sp);
	//관리자 - 포인트 내역 전체 조회, 검색 조회 
	ArrayList<Payment> selectAdPointList(PageInfo adPointPi, SearchPoint sp);
	//관리자 - 환불 내역 리스트 카운트
	int getAdRefundListCount(SearchPoint sp);
	//관리자 - 환불 내역 전체 조회, 검색 조회 
	ArrayList<Payment> selectAdRefundList(PageInfo adRefundPi, SearchPoint sp);
	//관리자 - 환불 상태 바꿔주기
	int updateRefund(Refund refund);
	//관리자 - 업데이트 된 환불 내역 들고오기
	Refund selectOneRefund(Refund refund);
	//관리자 - 환불 상태 성공시 산 사람의 userPoint 업데이트
	int updateUserPointRefund(Refund updatedRefund);
	//관리자 - 판 사람의 아이디 조회 -trvId 이용
	Proceeds selectMemberIdTrv(Refund updatedRefund);
	//관리자 - 판 사람의 아이디 조회 -planId 이용
	Proceeds selectMemberIdRequest(Refund updatedRefund);
	//관리자 - 판 사람의 userProceeds 차감
	int updateUserProceedsRefund(Proceeds proceeds);
	//포인트 사용시 판매자의 참여번호를 조회해와야 함
	int selectOnePtcp(int requestId);
	//포인트 사용시 차감된 userPoint 찾기
	int selectOnePoint(int mid);
	//관리자 - 수익금  리스트 카운트
	int getAdProceedsListCount(SearchPoint sp);
	//관리자 - 수익금 조회
	ArrayList<Proceeds> selectAdProceedsList(PageInfo adProceedsPi, SearchPoint sp);
	//명소리뷰코드로 명소코드 가져오기
	int selectSpotId(int spotReviewId);
	//관리자 - 환급 내역 리스트 카운트
	int getAdRebateListCount(SearchPoint sp);
	//관리자 - 환급 내역 조회
	ArrayList<Proceeds> selectAdRebateList(PageInfo adRebatePi, SearchPoint sp);
	//관리자 - 환급 상태 1개변경
	int updateAdRebate(int refundId);
	//관리자 - 환급 상태 여러개변경
	int updateAdRebates(int refundId);
	//관리자 - 미지급 내역 다운로드
	void downRebates(int rebateStatus, HttpServletRequest request, HttpServletResponse response) throws IOException;
	//일정리뷰 코드 이용하여 trvId조회
	int selectTrvId(int reviewId);
	//사용자 - 환급신청 내역 월 검색 리스트 카운트
	int selectOneRebateListCount(SearchPoint sp);
	//사용자 - 환급신청 내역 월 검색 조회
	ArrayList<Rebate> selectOneRebateList(PageInfo rebatePi, SearchPoint sp);
	//사용자 - 수익달성 내역 월 검색 리스트 카운트
	int selectOneProceedsListCount(SearchPoint sp);
	//사용자 - 수익달성 내역 월 검색 조회
	ArrayList<Proceeds> selectOneProceedsList(PageInfo proPi, SearchPoint sp);

}
