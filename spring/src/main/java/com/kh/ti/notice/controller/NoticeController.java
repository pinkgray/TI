package com.kh.ti.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService cc;
	
	//공지사항 리스트 - 이선우
	@RequestMapping("noticeList.cc")
	public String SelectNoticeList(HttpServletRequest request,
			   					   Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = cc.getNoticeCount();
		System.out.println("공지글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Board> list = cc.selectNoticeList(pi);
		
		System.out.println("공지 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "callCenter/noticeList";
	}
	
	//공지사항 상세보기 - 이선우
	@RequestMapping("noticeDetail.cc")
	public String selectNoticeDetail(@RequestParam("boardId")int boardId,
									 Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = cc.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "callCenter/noticeDetail";
		} else {
			return "common/errorPage";
		}
	}
	
	//자주묻는질문 리스트 - 이선우
	@RequestMapping("moreQuestionList.cc")
	public String selectMoreQuestionList(HttpServletRequest request,
				 Model model) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//전체 목록 조회
		int listCount = cc.getMoreQuestionCount();
		System.out.println("자주글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		ArrayList<Board> list = cc.selectMoreQuestionList(pi);
		
		System.out.println("자주글 목록 : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
				
		return "callCenter/moreQuestionList";
	}
			
	//자주묻는질문 상세보기 - 이선우
	@RequestMapping("moreQuestionDetail.cc")
	public String selectMoreQuestionDetail(@RequestParam("boardId")int boardId,
			   Model model) {
		System.out.println("공지 번호 : " + boardId);
		
		Board b = cc.selectOneNotice(boardId);
		System.out.println("조회 결과 : " + b);
		
		if(b != null) {
			model.addAttribute("b", b);	
			return "callCenter/moreQuestionDetail";
		} else {
			return "common/errorPage";
		}
	}
}
