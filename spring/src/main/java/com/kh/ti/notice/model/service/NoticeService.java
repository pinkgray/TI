package com.kh.ti.notice.model.service;

import java.util.ArrayList;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.common.PageInfo;

public interface NoticeService {

	int getNoticeCount();

	ArrayList<Board> selectNoticeList(PageInfo pi);

	Board selectOneNotice(int boardId);

	int getMoreQuestionCount();

	ArrayList<Board> selectMoreQuestionList(PageInfo pi);

}
