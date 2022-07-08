package com.kh.ti.member.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao{

	//비밀번호 확인용메소드 - 세령
	@Override
	public String selectEncPassword(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("Member.selectPwd", m.getEmail());
	}
	
	//로그인용메소드 - 세령
	@Override
	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("Member.selectLoginUser", m);
	}

	//회원가입용메소드 - 세령
	@Override
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("Member.insertMember", m);
	}

	//가입 포인트 적립용 메소드 - 세령
	@Override
	public int insertReservePoint(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.insert("Member.insertReservePoint", email);
	}

	//비밀번호 변경용 메소드 -- 세령
	@Override
	public int updateUserPwd(SqlSessionTemplate sqlSession, Member loginUser) {
		return sqlSession.update("Member.updatePwd", loginUser);
	}

	//회원탈퇴용 메소드 - 세령
	@Override
	public int dropOutUserInfo(SqlSessionTemplate sqlSession, Member loginUser) {
		return sqlSession.update("Member.updateEnrollStatus", loginUser);
	}

	//회원수정용 메소드 - 세령
	@Override
	public int updateUserInfo(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("Member.updateUserInfo", m);
	}

	//계좌정보수정용 메소드 - 세령
	@Override
	public int updateUserAcc(SqlSessionTemplate sqlSession, Member loginUser) {
		return sqlSession.update("Member.updateAcc", loginUser);
	}

	//(관리자) 회원수 조회용 메소드 - 세령
	@Override
	public int getListCount(SqlSessionTemplate sqlSession, String status) {
		return sqlSession.selectOne("Member.selectListCount", status);
	}

	//(관리자) 회원정보 전체 조회용 메소드 - 세령
	@Override
	public ArrayList<Member> selectAllMember(SqlSessionTemplate sqlSession, PageInfo pi, String status) {
		ArrayList<Member> mList = null;
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		mList = (ArrayList) sqlSession.selectList("Member.selectAllMemberList", status, rowBounds);
		return mList;
	}

	//회원정보 조건 조회용 메소드 - 세령
	@Override
	public ArrayList<Member> selectConditionMember(SqlSessionTemplate sqlSession, Map<String, String> map) {
		ArrayList<Member> mList = (ArrayList) sqlSession.selectList("Member.selectConditionList", map);
		return mList;
	}

	//이메일로 회원정보 수정용 메소드 - 세령
	@Override
	public int updatePasswordFromFind(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("Member.updatePasswordFromFind", member);
	}

	//이메일로 회원 조회용 메소드 - 세령
	@Override
	public Member selectMemberEmail(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("Member.selectMemberEmail", email);
	}

	//현재 MEMBER 시퀀스 얻기용 메소드 - 세령
	@Override
	public int getCurrentMemberId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("Member.currentMemberSeq", m);
	}

}
