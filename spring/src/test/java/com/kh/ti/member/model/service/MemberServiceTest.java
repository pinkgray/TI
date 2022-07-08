package com.kh.ti.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.ModelMap;

import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.member.model.exception.LoginException;
import com.kh.ti.member.model.vo.Member;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/config/member-servlet.xml",
					  "file:src/main/resources/root-context.xml",
					  "file:src/main/webapp/WEB-INF/config/spring-security.xml"})
@WebAppConfiguration
public class MemberServiceTest {
	
	private static final Logger log = LoggerFactory.getLogger(MemberServiceTest.class);
	
	private Member m;
	@Autowired
	private MemberService ms;
	PageInfo pi;
	String status;
	Map<String, String> map;
	
	@Before
	public void setup() {
		m = new Member();
//		m.setMemberId(100);
		m.setEmail("tpfud0922@naver.com");
		m.setPassword("0000");
		m.setUserName("박세령");
		m.setEnrollType("카카오가입");
//		m.setBirthday("1997-09-22");
//		m.setGender("F");
//		m.setPhone("010-9226-0374");
//		m.setAccCode("003");
//		m.setAccNumber("01092260374");
		
		int currentPage = 1;
		int listCount = 20;
		pi = Pagination.getPageInfo(currentPage, listCount);
		status = "ALL";
		
		map = new HashMap<String, String>();
		map.put("condition", "phone");
		map.put("conditionValue", "010-1234-5678");
		
		System.out.println("셋팅 완료!");
	}
	
	@Ignore
	@Test
	public void testInsertMember() {
		ms.insertMember(m);
		log.info("회원가입 성공!");
	}
	
	@Ignore
	@Test
	public void testSelectLoginUser() throws LoginException {
		ms.loginMember(m);
		log.info("로그인 성공!");
	}
	
	@Ignore
	@Test
	public void testUpdateUserPwd() throws LoginException {
		ms.updateUserPwd(m, "0000", "1234");
		log.info("비밀번호 수정 성공!");
	}
	
	@Ignore
	@Test
	public void testDropOutUserInfo() {
		ms.dropOutUserInfo(m);
		log.info("회원 탈퇴 성공!");
	}
	
	@Ignore
	@Test
	public void testUpdateUserInfo() {
		ms.updateUserInfo(m);
		log.info("회원 정보 수정 성공!");
	}
	
	@Ignore
	@Test
	public void testUpdateUserAcc() {
		ms.updateUserAcc(m);
		log.info("계좌 정보 수정 성공!");
	}
	
	@Ignore
	@Test
	public void testGetListCount() {
		int result = ms.getListCount(status);
		System.out.println(status);
		log.info("회원 수 조회 성공! : " + result);
	}
	
	@Ignore
	@Test
	public void testSelectAllMember() {
		ArrayList<Member> mList = ms.selectAllMember(pi, status);
		log.info("회원 전체 조회 성공!" + mList.size());
	}
	
	@Ignore
	@Test
	public void testSelectConditionMember() {
		ArrayList<Member> mList = ms.selectConditionMember(map);
		log.info("회원 조건 조회 성공!");	
		log.info(mList.get(0).toString());
	}
	
	@Ignore
	@Test
	public void testTempPasswordMake() {
		String[] chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "N", "M", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
				"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "n", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
				"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
		
		int num = 0;
		String tempPassword = "";
		for(int i = 0; i < 6; i++) {
			num = (int) (Math.random() * 61) + 1;
			tempPassword += chars[num];
		} //end for
		
		log.info("임시비밀번호 생성 완료! - " + tempPassword + ", " + chars.length);
	}
	
	@Ignore
	@Test
	public void testUpdatePasswordFromFind() {
		ms.updatePasswordFromFind(m);
		log.info("이메일로 비밀번호 수정 성공!");
	}
	
	@Ignore
	@Test
	public void testSelectMemberEmail() {
		Member member = ms.selectMemberEmail(m.getEmail());
		log.info("이메일로 회원 조회 성공!");
		log.info(member.toString());
	}
}
