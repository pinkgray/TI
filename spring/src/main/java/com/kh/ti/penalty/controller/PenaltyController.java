package com.kh.ti.penalty.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
//신고 및 문의
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ti.common.CommonUtils;
import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.penalty.model.service.PenaltyService;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.penalty.model.vo.PenaltyAttachment;
import com.kh.ti.travelRequest.model.vo.TravelRequest;

@Controller
public class PenaltyController {
	
	@Autowired
	private PenaltyService ps;
	
	
	//신고할 대상 조회 - 이선우
	@RequestMapping("selectPanelty.pe")
	public ResponseEntity selectPanelty(
		@RequestParam("code")int code) {
		
		System.out.println("구분 : " + code);
		return new ResponseEntity(code, HttpStatus.OK);
	}
	// 신고하기 - 이선우
		@RequestMapping("insertPanelty.pe")
		public String insertPanelty(@ModelAttribute Penalty p,
				@RequestParam("attachmentFile") ArrayList<MultipartFile> attachmentFile,
				HttpServletRequest request,
				Model model) {
			System.out.println(p);
			System.out.println(attachmentFile);
			System.out.println(attachmentFile.size());
			
			//attachmentFile에 대한 처리
			String root = request.getSession().getServletContext().getRealPath("resources");
			String filePath = root + "\\uploadFiles";
			
			System.out.println(root);
			System.out.println(filePath);
			
			ArrayList<PenaltyAttachment> attachmentFileList = new ArrayList<PenaltyAttachment>();
			
			int i = 0;
			for(MultipartFile attachment : attachmentFile) {
				String originFileName = attachment.getOriginalFilename();	//원본이름
				String ext = originFileName.substring(originFileName.lastIndexOf(".")); //확장자명
				String changeName = CommonUtils.getRandomString();	//바뀐이름
				System.out.println("원본이름 : " + originFileName);
				System.out.println("확장자명 : " + ext);
				System.out.println("바뀐이름 : " + changeName);
				
				PenaltyAttachment pe = new PenaltyAttachment();
				pe.setOriginName(originFileName);
				pe.setChangeName(changeName + ext);
				pe.setFilePath(filePath);
				pe.setFileType("신고");
				attachmentFileList.add(pe);
				
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

			switch (p.getList()) {
			case "의뢰글":
				p.setRequestId(Integer.parseInt(p.getListType()));
				System.out.println("의뢰글 번호 : " + p.getRequestId());
				break;
			case "설계글":
				p.setPlanId(Integer.parseInt(p.getListType()));
				System.out.println("설계글 번호 : " + p.getPlanId());
				break;
			case "일정글" :
				p.setTrvId(Integer.parseInt(p.getListType()));
				System.out.println("여행 일정글 번호: " + p.getTrvId());
				break;
			case "리뷰" :
				p.setReviewId(Integer.parseInt(p.getListType()));
				System.out.println("리뷰 번호 : " + p.getReviewId());
				break;
			case "채팅":
				p.setMemberId(Integer.parseInt(p.getListType()));
				System.out.println("채팅자 멤버번호 : " + p.getMemberId());
				break;
			}
			
			if ( p.getPenaltyContent().equals("")) {
				p.setPenaltyContent("신고사유참고");
			}
			
			System.out.println("신고내용 : " + p.getPenaltyContent());
			System.out.println("신고종류 코드 : " + p.getPenaltyId());
			System.out.println("신고자 : " + p.getComplainantId());
			System.out.println("구분 : " + p.getList());
			System.out.println(p);
			
			
			
			int result = ps.insertPenalty(p, attachmentFileList);
			int memberId = p.getComplainantId();
			
			if (p.getList().equals("채팅")) {
				String chatId = request.getParameter("chatId");
				
				return "redirect:enterChatting.ch?num=" + chatId;
			}else {
				return "redirect:paneltyList.pe?memberId=" + memberId;
			}
			
	
		}
	
	// 신고 내역 - 이선우
	@RequestMapping("paneltyList.pe")
	public String selectPaneltyList(@RequestParam("memberId")int memberId,
									HttpServletRequest request,
									Model model) {
		
		//신고내역 조회
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = ps.getPenaltyCount(memberId);
		System.out.println("나의 신고글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		
		ArrayList<Penalty> list = ps.selectPenaltyList(pi, memberId);
		
		System.out.println("나의 신고 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "panelty/paneltyList";
	}

	// 신고 내역상세보기 - 이선우
	@RequestMapping("paneltyDetail.pe")
	public String selectPenaltyDetail(@RequestParam("listId")int listId, Model model) {
		System.out.println("신고 번호 : " + listId);
		
		Penalty p = ps.selectOnePenalty(listId);
		System.out.println("조회 결과 : " + p);
		
		if(p != null) {
			model.addAttribute("p", p);
			return "panelty/paneltyDetail";			
		} else {
			return "common/errorPage";
		}
	}
}
