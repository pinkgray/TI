package com.kh.ti.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.dao.MemberDao;
import com.kh.ti.member.model.exception.LoginException;
import com.kh.ti.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MemberDao md;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	//로그인용메소드 - 세령
	@Override
	public Member loginMember(Member m) throws LoginException {
		Member loginUser = null;
		String encPassword = md.selectEncPassword(sqlSession, m);
		if(encPassword == null || encPassword == "") {
			throw new LoginException("일치하는 회원 정보가 없습니다!");
		} else if(!passwordEncoder.matches(m.getPassword(), encPassword)){
			throw new LoginException("비밀번호가 일치하지 않습니다!");
		}else {
			loginUser = md.selectMember(sqlSession, m);			
		}	
		return loginUser;
	}

	//회원가입용 메소드 - 세령
	@Override
	public int insertMember(Member m) {
		int result = 0;
		int resultInsertMember = md.insertMember(sqlSession, m);
		int resultInsertReservePoint = md.insertReservePoint(sqlSession, m.getEmail());
		if(resultInsertMember > 0 && resultInsertReservePoint > 0) {
			result = 1;
		} else {
			result = 0;
		}
		return result;
	}

	//비밀번호 수정용 메소드 - 세령
	@Override
	public int updateUserPwd(Member loginUser, String oldPassword, String newPassword) throws LoginException {
		String encPassword = md.selectEncPassword(sqlSession, loginUser);
		int result = 0;
		if(!passwordEncoder.matches(oldPassword, encPassword)) {
			throw new LoginException("비밀번호가 일치하지 않습니다!");
		} else {
			String encPassword2 = passwordEncoder.encode(newPassword);
			loginUser.setPassword(encPassword2);
			result = md.updateUserPwd(sqlSession, loginUser);
		}
		return result;
	}

	//회원탈퇴용 메소드 - 세령
	@Override
	public int dropOutUserInfo(Member loginUser) {
		int result = md.dropOutUserInfo(sqlSession, loginUser);
		return result;
	}

	//회원수정용 메소드 - 세령
	@Override
	public int updateUserInfo(Member m) {
		return md.updateUserInfo(sqlSession, m);
	}

	//계좌정보수정용 메소드 - 세령
	@Override
	public int updateUserAcc(Member loginUser) {
		return md.updateUserAcc(sqlSession, loginUser);
	}

	//회원수 조회용 메소드 - 세령
	@Override
	public int getListCount(String status) {
		return md.getListCount(sqlSession, status);
	}

	//회원정보전체조회용메소드 - 세령
	@Override
	public ArrayList<Member> selectAllMember(PageInfo pi, String status) {
		return md.selectAllMember(sqlSession, pi, status);
	}

	//회원정보 조건 조회용 메소드 - 세령
	@Override
	public ArrayList<Member> selectConditionMember(Map<String, String> map) {
		return md.selectConditionMember(sqlSession, map);
	}

	//이메일로 비밀번호 수정용 메소드 - 세령
	@Override
	public int updatePasswordFromFind(Member member) {
		return md.updatePasswordFromFind(sqlSession, member);
	}

	//이메일로 회원 검색 - 세령
	@Override
	public Member selectMemberEmail(String email) {
		return md.selectMemberEmail(sqlSession, email);
	}

	//현재 MEMBER 시퀀스 얻기용 메소드 - 세령
	@Override
	public int getCurrentMemberId(Member m) {
		return md.getCurrentMemberId(sqlSession, m);
	}

}
