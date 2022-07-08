package com.kh.ti.adminCallCenter.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ti.adminCallCenter.model.service.AdminCallCenterService;
import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.adminCallCenter.model.vo.BoardAttachment;
import com.kh.ti.adminCallCenter.model.vo.Total;
import com.kh.ti.common.CommonUtils;
import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.travelRequest.model.vo.TravelRequest;


//관리자 고객센터
@Controller
public class AdminCallCenterController {
	
	@Autowired
	private AdminCallCenterService ccs;
	
	//관리자 공지사항 리스트 - 이선우
	@RequestMapping("adminNoticeList.ad")
	public String SelectNoticeList(HttpServletRequest request,
								   Model model) {	
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getNoticeCount();
		System.out.println("공지글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Board> list = ccs.selectNoticeList(pi);
		
		System.out.println("공지 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "admin/callCenter/adminNoticeList";
	}
	
	//관리자 공지사항 상세보기 - 이선우
	@RequestMapping("adminNoticeDetail.ad")
	public String selectNoticeDetail(@RequestParam("boardId")int boardId,
									 Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = ccs.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "admin/callCenter/adminNoticeDetail";
		} else {
			return "common/errorPage";
		}
	}
	
	//관리자 공지사항 작성폼 - 이선우
	@RequestMapping("insertNoticeForm.ad")
	public String insertNoticeForm() {
		
		return "admin/callCenter/insertNotice";
	}
	
	//관리자 공지사항 작성 - 이선우
	@RequestMapping("insertNotice.ad")
	public String insrtNotice(@ModelAttribute Board b,
							  @RequestParam("attachmentFile") ArrayList<MultipartFile> attachmentFile,
							  HttpServletRequest request,
						      Model model) {
		System.out.println(b);
		System.out.println(attachmentFile);
		System.out.println("초기 파일 갯수 : " + attachmentFile.size());
		
		//attachmentFile에 대한 처리
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		
		System.out.println(root);
		System.out.println(filePath);
		
		ArrayList<BoardAttachment> attachmentFileList = new ArrayList<BoardAttachment>();
		
		if(attachmentFile.size() > 0) {
			int i = 0;
			for(MultipartFile attachment : attachmentFile) {
				String originFileName = attachment.getOriginalFilename();	//원본이름
				String ext = originFileName.substring(originFileName.lastIndexOf(".")); //확장자명
				String changeName = CommonUtils.getRandomString();	//바뀐이름
				System.out.println("원본이름 : " + originFileName);
				System.out.println("확장자명 : " + ext);
				System.out.println("바뀐이름 : " + changeName);
				
				BoardAttachment ba  = new BoardAttachment();
				ba.setOriginName(originFileName);
				ba.setChangeName(changeName + ext);
				ba.setFilePath(filePath);
				ba.setFileType("고객센터");
				attachmentFileList.add(ba);
				
				System.out.println(attachmentFileList.get(i));
				
				try {
					attachment.transferTo(new File(filePath + "\\" + changeName + ext));
					System.out.println("원본명 : " + originFileName);
					System.out.println("바뀐명 : " + changeName);
					
				} catch(Exception e) {
					//실패시 파일 삭제
					new File(filePath + "\\" + changeName + ext).delete();
				}
				i++;
			}
		}
		
		int result = ccs.insertNotice(b, attachmentFileList);
		
		return "redirect:adminNoticeList.ad";
	}
	
	//관리자 공지사항 수정폼 - 이선우
	@RequestMapping("updateNoticeForm.ad")
	public String updateNoticeForm(@RequestParam("boardId")int boardId,
								   Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = ccs.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "admin/callCenter/updateNotice";
		} else {
			return "common/errorPage";
		}
	}
	
	//관리자 공지사항 수정
	@RequestMapping("updateNotice.ad")
	public String updateNotice(@ModelAttribute Board b, HttpServletRequest request,
							   Model model) {
		System.out.println("공지 번호 : " + b.getBoardId());
		System.out.println("공지 제목 : " + b.getBoardTitle());
		System.out.println("공지 내용: " + b.getBoardContent());
		
		int result = ccs.updateNotice(b);
		return "redirect:adminNoticeList.ad";
	}
	
	//관리자 자주묻는질문 작성  폼 - 이선우
	@RequestMapping("insertMoreQuestionForm.ad")
	public String insertMoreQuestionForm() {
		
		return "admin/callCenter/insertMoreQuestion";
	}
	
	//관리자 자주묻는질문 작성- 이선우
	@RequestMapping("insertMoreQuestion.ad")
	public String insertMoreQuestion(@ModelAttribute Board b,
									 @RequestParam("attachmentFile") ArrayList<MultipartFile> attachmentFile,
									 HttpServletRequest request,
								     Model model) {
		System.out.println(b);
		System.out.println(attachmentFile);
		System.out.println("초기 파일 갯수 : " + attachmentFile.size());
		
		//attachmentFile에 대한 처리
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		
		System.out.println(root);
		System.out.println(filePath);
		
		ArrayList<BoardAttachment> attachmentFileList = new ArrayList<BoardAttachment>();
		
		if(attachmentFile.size() > 0) {
			int i = 0;
			for(MultipartFile attachment : attachmentFile) {
				String originFileName = attachment.getOriginalFilename();	//원본이름
				String ext = originFileName.substring(originFileName.lastIndexOf(".")); //확장자명
				String changeName = CommonUtils.getRandomString();	//바뀐이름
				System.out.println("원본이름 : " + originFileName);
				System.out.println("확장자명 : " + ext);
				System.out.println("바뀐이름 : " + changeName);
				
				BoardAttachment ba  = new BoardAttachment();
				ba.setOriginName(originFileName);
				ba.setChangeName(changeName + ext);
				ba.setFilePath(filePath);
				ba.setFileType("고객센터");
				attachmentFileList.add(ba);
				
				System.out.println(attachmentFileList.get(i));
				
				try {
					attachment.transferTo(new File(filePath + "\\" + changeName + ext));
					System.out.println("원본명 : " + originFileName);
					System.out.println("바뀐명 : " + changeName);
					
				} catch(Exception e) {
					//실패시 파일 삭제
					new File(filePath + "\\" + changeName + ext).delete();
				}
				i++;
			}
		}
		int result = ccs.insertNotice(b, attachmentFileList);
		
		return "redirect:adminMoreQuestionList.ad";
	}
	
	//관리자 자주묻는질문 리스트 - 이선우
	@RequestMapping("adminMoreQuestionList.ad")
	public String selectMoreQuestionList(HttpServletRequest request,
			   							 Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getMoreQuestionCount();
		System.out.println("자주글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Board> list = ccs.selectMoreQuestionList(pi);
		
		System.out.println("자주글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/callCenter/adminMoreQuestionList";
	}
	
	//관리자 자주묻는질문 상세보기 - 이선우
	@RequestMapping("adminMoreQuestionDetail.ad")
	public String selectMoreQuestionDetail(@RequestParam("boardId")int boardId,
										   Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = ccs.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "admin/callCenter/adminMoreQuestionDetail";
		} else {
			return "common/errorPage";
		}
	}
	
	
	//관리자 자주묻는질문 수정폼 - 이선우
	@RequestMapping("updateMoreQuestionForm.ad")
	public String updateMoreQuestionForm(@RequestParam("boardId")int boardId,
										 Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = ccs.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "admin/callCenter/updateMoreQuestion";
		} else {
			return "common/errorPage";
		}
	}
	
	//관리자 자주묻는질문 수정 - 이선우
	@RequestMapping("updateMoreQuestion.ad")
	public String updateMoreQuestion(@ModelAttribute Board b, HttpServletRequest request,
			   Model model) {
		System.out.println("공지 번호 : " + b.getBoardId());
		System.out.println("공지 제목 : " + b.getBoardTitle());
		System.out.println("공지 내용: " + b.getBoardContent());
			
			int result = ccs.updateMoreQuestion(b);
		return "redirect:adminMoreQuestionList.ad";
	}
	
	
	//관리자 1:1문의 리스트  - 이선우
	@RequestMapping("oneToOneList.ad")
	public String selectOneToOneList(HttpServletRequest request,
				 Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getOneToOneCount();
		System.out.println("문의글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Inquiry> list = ccs.selectOneToOneList(pi);
		
		System.out.println("문의글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/callCenter/oneToOneList";
	}
	
	//관리자 1:1문의 상세보기 - 이선우
	@RequestMapping("oneToOneDetail.ad")
	public String slectOneToOneDetail(@RequestParam("inquiryId")int inquiryId,
									  Model model) {
		System.out.println("문의 번호 : " + inquiryId);
		
		Inquiry i = ccs.selectOneInquiry(inquiryId);
		System.out.println("조회 결과 : " + i);
		
		if(i != null) {
			model.addAttribute("i", i);	
			return "admin/callCenter/oneToOneDetail";
		} else {
			return "common/errorPage";
		}
	}
	
	//관리자 1:1문의 처리 - 이선우
	@RequestMapping("updateInquiry.ad")
	public String updateInquiry(@ModelAttribute Inquiry i) {
		System.out.println("문의 번호 : " + i.getInquiryId());
		System.out.println("답변 내용 : " + i.getReplyContent());
		
		Inquiry inquiry = new Inquiry();
		inquiry.setInquiryId(i.getInquiryId());
		inquiry.setReplyContent(i.getReplyContent());
		
		int result = ccs.updateInquiry(inquiry);
		return "redirect:oneToOneList.ad";
	}
	
	//관리자 신고관리 조회 - 이선우
	@RequestMapping("reportControlList.ad")
	public String selectReportControlList(HttpServletRequest request,
			 							  Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getAdminPenaltyCount();
		System.out.println("신고글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Inquiry> list = ccs.selectAdminPenaltyList(pi);
		
		System.out.println("문의글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/reportControl/reportControlList";
	}
	
	//관리자 신고관리 상세보기 - 이선우
	@RequestMapping("reportControlDetail.ad")
	public String selectReportControlDetail(@RequestParam("listId")int listId,
											@RequestParam("complainantName")String complainantName,
											@RequestParam("userName")String userName,
											@RequestParam("penalty")int penalty,
											Model model) {
		System.out.println("신고번호 : " + listId);
		System.out.println("신고자 : " + complainantName);
		System.out.println("대상자 : " + userName);
		System.out.println("누적벌점 : " + penalty);
		
		Penalty p = ccs.selectOnePenalty(listId);
		System.out.println("조회 결과 : " + p);
		
		if(p != null) {
			model.addAttribute("p", p);
			model.addAttribute("complainantName", complainantName);
			model.addAttribute("userName", userName);
			model.addAttribute("penalty", penalty);
			return "admin/reportControl/reportControlDetail";	
		} else {
			return "common/errorPage";
		}
	}
	
	//관리자 신고 처리 조회 - 이선우
	@RequestMapping("selectPenaltyOk.ad")
	public ResponseEntity selectPanelty(
		@RequestParam("listId")int listId) {
		
		System.out.println("신고번호 : " + listId);
		
		Penalty p = ccs.selectPenaltyOk(listId);
		System.out.println("조회결과 : " + p);
		return new ResponseEntity(p, HttpStatus.OK);
	}
	
	//관리자 신고 승인 처리
	@RequestMapping("updatePenaltyOk.ad")
	public String updatePenaltyOk(@ModelAttribute Penalty p) {
		System.out.println(p);
		
		int updatePenaltyOk = ccs.updatePenaltyOk(p);
		
		return "redirect:reportControlList.ad";
	}
	
	//관리자 신고 거절 처리
	@RequestMapping("updatePenaltyNo.ad")
	public String updatePenaltyNo(@ModelAttribute Penalty p) {
		System.out.println(p);
		
		int updatePenaltyNo = ccs.updatePenaltyNo(p);
		
		return "redirect:reportControlList.ad";
	}
	
	
	//관리자 게시판관리 의뢰조회 - 이선우
	@RequestMapping("reqTotalList.ad")
	public String selectReqTotalList(HttpServletRequest request,
			  Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getReqTotalCount();
		System.out.println("의뢰글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<TravelRequest> list = ccs.selectReqTotalList(pi);
		
		System.out.println("의뢰글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/noticeControl/reqTotalList";
	}
	
	//관리자 게시판관리 설계조회 - 이선우
	@RequestMapping("planTotalList.ad")
	public String selectPlanTotalList(HttpServletRequest request,
			  Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getPlanTotalCount();
		System.out.println("참여글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<TravelRequest> list = ccs.selectPlanTotalList(pi);
		
		System.out.println("참여글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/noticeControl/planTotalList";
	}
	
	//관리자 게시판관리 일정조회 - 이선우
	@RequestMapping("trvTotalList.ad")
	public String selectTrvTotalList(HttpServletRequest request,
			  Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getTrvTotalCount();
		System.out.println("일정글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<TravelRequest> list = ccs.selectTrvTotalList(pi);
		
		System.out.println("일정글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/noticeControl/trvTotalList";
	}
	
	//관리자 게시판관리 리뷰조회 - 이선우
	@RequestMapping("reviewTotalList.ad")
	public String selectReviewTotalList(HttpServletRequest request,
			  Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ccs.getReviewTotalCount();
		System.out.println("의뢰글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<TravelRequest> list = ccs.selectReviewTotalList(pi);
		
		System.out.println("의뢰글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/noticeControl/reviewTotalList";
	}
	
	//관리자 의뢰글 삭제 - 이선우
	@RequestMapping("reqDelete.ad")
	public String updateReqDelete(@RequestParam("reqId")int reqId) {
		System.out.println("의뢰 번호 : " + reqId);
		
		int result = ccs.updateReqDelete(reqId);
		return "redirect:reqTotalList.ad";
	}
	
	//관리자 설계글 삭제 - 이선우
	@RequestMapping("planDelete.ad")
	public String updatePlanDelete(@RequestParam("ptcpId")int ptcpId) {
		System.out.println("참여 번호 : " + ptcpId);
		
		int result = ccs.updatePlanDelete(ptcpId);
		
		return "redirect:planTotalList.ad";
	}
	
	//관리자 여행일정 삭제 - 이선우
	@RequestMapping("trvDelete.ad")
	public String updateTrvDelete(@RequestParam("trvId")int trvId) {
		System.out.println("일정 번호 : " + trvId);
		
		int result = ccs.updateTrvDelete(trvId);
		
		return "redirect:trvTotalList.ad";
	}
	
	//관리자 리뷰 삭제 - 이선우
	@RequestMapping("reviewDelete.ad")
	public String updateReviewDelete(@RequestParam("reviewId")int reviewId) {
		System.out.println("리뷰 번호 : " + reviewId);
		
		int result = ccs.updateReviewDelete(reviewId);
		
		return "redirect:reviewTotalList.ad";
	}
}
