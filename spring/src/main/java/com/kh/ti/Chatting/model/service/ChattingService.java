package com.kh.ti.Chatting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.Tag;

@Service
public interface ChattingService {

	//사용자 정보 불러오기 - 지원
	public Member selectMemberInfo(int userId);

	public ArrayList<Country> selectContryList();

	public ArrayList<Tag> selectTagList();

	public HashMap<String, ArrayList> selectRankTagList();
}
