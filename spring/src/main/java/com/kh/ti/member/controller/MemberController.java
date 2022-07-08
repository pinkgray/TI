package com.kh.ti.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.member.model.exception.LoginException;
import com.kh.ti.member.model.service.MemberService;
import com.kh.ti.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class MemberController {

	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// 로그인화면 보여주기 전용(forward loginForm.jsp)--세령
	@RequestMapping("loginForm.me")
	public String showLoginForm() {
		return "member/loginForm";
	}

	// 회원정보수정화면 보여주기 전용(forward updateMemberInfo.jsp)--세령
	@RequestMapping("updateMemberForm.me")
	public String showMemberInfo(Model model, HttpServletRequest request) {
		return "member/updateMemberInfo";
	}

	// 관리자회원관리화면 보여주기 전용(forward adminMemberList.jsp)--세령
	@RequestMapping("adminMemberListForm.me")
	public String showAdminMemberList(Model model, @RequestParam("currentPage") int currentPage,
			@RequestParam("status") String status) {
		// 조회 기능 추가
		int listCount = ms.getListCount(status);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Member> mList = ms.selectAllMember(pi, status);
		model.addAttribute("mList", mList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pi", pi);
		model.addAttribute("status", status);
		return "admin/member/adminMemberList";
	}

	// 계좌정보변경 창 띄우기용 메소드(forward confirmAccountPopup.jsp) --세령
	@RequestMapping("showConfirmAcc.me")
	public String showConfirmAccPopup() {
		return "member/confirmAccount";
	}

	// 로그인용메소드--세령--세령
	@RequestMapping("login.me")
	public String loginCheck(@ModelAttribute Member m, Model model) {
		Member loginUser = null;
		try {
			loginUser = ms.loginMember(m);
			model.addAttribute("loginUser", loginUser);
			return "redirect:index.jsp";
		} catch (LoginException e) {
			model.addAttribute("msg", e.getMessage());
			return "member/loginForm";
		} // end try
	}

	// 카카오로 로그인 - 세령
	@RequestMapping("kakaoLogin.me")
	public String kakaoLogin(@ModelAttribute Member m, Model model) {
		if (m.getEmail() == null || m.getEmail() == "") {
			m.setEmail("KAKAO" + m.getPassword());
		}

		Member loginUser = null;
		String path = "";
		int memberId;
		try {
			loginUser = ms.loginMember(m);
			model.addAttribute("loginUser", loginUser);
			path = "redirect:index.jsp";
		} catch (LoginException e) {
			String encPassword = passwordEncoder.encode(m.getPassword());
			m.setPassword(encPassword);
			int result = ms.insertMember(m);
			if (result > 0) {
				memberId = ms.getCurrentMemberId(m);
				m.setMemberId(memberId);
				model.addAttribute("loginUser", m);
				path = "redirect:index.jsp";
			} else {
				model.addAttribute("msg", "카카오로그인에 실패했습니다.");
				path = "member/loginForm";
			} // end if
		} // end try

		return path;
	}

	// 로그아웃용메소드--세령--세령
	@RequestMapping("logout.me")
	public String logoutMember(SessionStatus status) {
		status.setComplete();
		return "redirect:index.jsp";
	}

	// 회원가입용메소드--세령
	@RequestMapping("insert.me")
	public String insertMember(@ModelAttribute Member m, Model model) {
		// 비밀번호 암호화
		String encPassword = passwordEncoder.encode(m.getPassword());
		m.setPassword(encPassword);

		int result = ms.insertMember(m);
		if (result > 0) {
			return "redirect:index.jsp";
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "common/errorPage";
		}
	}

	// 비밀번호수정용메소드--세령
	@RequestMapping("updateUserPwd.me")
	public String updateUserPwd(@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword, HttpServletRequest request, SessionStatus status,
			Model model) {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");

		try {
			int result = ms.updateUserPwd(loginUser, oldPassword, newPassword);
			status.setComplete();
			return "redirect:index.jsp";
		} catch (LoginException e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}

	// 계좌정보수정용메소드--세령
	@RequestMapping("updateUserAcc.me")
	public String updateUserAcc(@RequestParam("bankcode") String accCode, @RequestParam("accnum") String accNumber,
			Model model, HttpServletRequest request) {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		loginUser.setAccCode(accCode);
		loginUser.setAccNumber(accNumber);
		int result = ms.updateUserAcc(loginUser);
		if (result > 0) {
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("success", "success");
		} else {
			model.addAttribute("msg", "계좌정보수정 실패!");
			// return "common/erroPage";
		}
		return "member/confirmAccount";
	}

	// 회원정보수정용메소드--세령
	@RequestMapping("updateUserInfo.me")
	public String updateUserInfo(@ModelAttribute Member m, Model model, HttpServletRequest request) {
		int result = ms.updateUserInfo(m);
		if (result > 0) {
			// 세션 정보 업데이트
			Member loginUser = (Member) request.getSession().getAttribute("loginUser");
			loginUser.setUserName(m.getUserName());
			loginUser.setEmail(m.getEmail());
			loginUser.setGender(m.getGender());
			loginUser.setBirthday(m.getBirthday());
			model.addAttribute("loginUser", loginUser);
			return "member/updateMemberInfo";
		} else {
			model.addAttribute("msg", "회원정보수정 실패!");
			return "common/errorPage";
		}
	}

	// 회원탈퇴용메소드--세령
	@RequestMapping("dropOutUser.me")
	public String dropOutUserInfo(HttpServletRequest request, SessionStatus status, Model model) {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		int result = ms.dropOutUserInfo(loginUser);
		if (result > 0) {
			status.setComplete();
			return "redirect:index.jsp";
		} else {
			model.addAttribute("msg", "회원탈퇴 실패!");
			return "common/errorPage";
		}
	}

	// 회원조건조회용메소드--세령
	@RequestMapping("selectCondition.me")
	public String selectConditionMemberList(@RequestParam("condition") String condition,
			@RequestParam("conditionValue") String conditionValue, Model model) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("condition", condition);
		map.put("conditionValue", conditionValue);

		ArrayList<Member> mList = ms.selectConditionMember(map);
		model.addAttribute("mList", mList);
		return "admin/member/adminMemberList";
	}

	// 회원게시글내역화면전환용메소드--세령
	@RequestMapping("selectUserBoard.me")
	public String selectUserBoardList() {
		return null;
	}

	// 회원신고내역화면전환용메소드--세령
	@RequestMapping("selectUserNotify.me")
	public String selectUserNotifyList() {
		return null;
	}

	// 회원결제내역화면전환용메소드--세령
	@RequestMapping("selectUserPay.me")
	public String selectUserPayList() {
		return null;
	}

	// 회원문의내역화면전환용메소드--세령
	@RequestMapping("selectUserInquiry.me")
	public String selectUserInquiryList() {
		return null;
	}

	// 이메일발송용 메소드 -- 세령
	@RequestMapping("mailSend.me")
	public void mailSend(HttpServletResponse response, @RequestParam("email") String email, ModelMap mo)
			throws AddressException, MessagingException, UnsupportedEncodingException {
		Member member = ms.selectMemberEmail(email);
		int resultNum = 0;
		if (member != null) {

			String host = "smtp.naver.com";
			final String username = "tpfud0922";
			final String password = "mashimaro0*22";
			int port = 465;

			String recipient = email;
			String subject = "Travel Interface 비밀번호 찾기";
			String body = "";
			String targetPath = "http://192.168.30.107:8001/ti/updatePwdFromFindPwd.me";

			body += "<form action='" + targetPath + "' method='post'>";
			body += "<div style='border: 1px solid gray; background-color: #e6eeff; padding: 20px;'>";
			body += "<h1><strong>Travel Interface</strong> 에서 발송된 메일입니다. </h1>";
			body += "<hr style='border: 1px solid #003399;'>";
			body += "<div>";
			body += "<h4> 안녕하세요. Travel Interface 고객님! <br> 비밀번호 재설정을 위한 버튼을 클릭해 주세요. </h4>";
			body += "<br>";
			/* body += "<h4><strong>임시 비밀번호 : </strong>" + tempPassword + "</h4>"; */
			body += "<input type='text' style='display: none;' value='" + email + "' name='email'>";
			body += "<button type='submit' target='_blank' style='background-color: #8a00e6; padding: 10px; border: 0px;"
					+ "color: white; cursor: pointer;'>비밀번호 재설정 </button>";
			body += "<br>";
			body += "<p><strong>감사합니다.</strong></p>";
			body += "</div>";
			body += "</form>";

			Properties props = System.getProperties();

			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", host);

			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un = username;
				String pw = password;

				protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
					return new javax.mail.PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true); // for debug
			Message mimeMessage = new MimeMessage(session); // MimeMessage 생성
			mimeMessage.setFrom(new InternetAddress("tpfud0922@naver.com", "Travel Interface")); // 발신자 셋팅 , 보내는 사람의
																									// 이메일주소를 한번 더
																									// 입력합니다. 이때는 이메일 풀
																									// 주소를 다 작성해주세요.

			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); // 수신자셋팅 //.TO 외에
																								// .CC(참조) .BCC(숨은참조) 도
																								// 있음

			mimeMessage.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B")); // 제목셋팅
			mimeMessage.setText(body); // 내용셋팅
			mimeMessage.setContent(body, "text/html; charset=UTF-8");
			Transport.send(mimeMessage); // javax.mail.Transport.send() 이용
			resultNum = 1;
		} else {
			resultNum = 0;
		} // end if

		try {
			response.getWriter().print(resultNum);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // end try
	}

	// 비밀번호 수정화면 전환용 메소드(비밀번호 찾기로 발송된 이메일로부터 forword) - 세령
	@RequestMapping("updatePwdFromFindPwd.me")
	public String updatePasswordFromFindPassword(Model model, @RequestParam("email") String email) {
		model.addAttribute("email", email);
		return "member/updatePasswordFromFind";
	}

	// 이메일로 비밀번호 수정 - 세령
	@RequestMapping("changePasswordFromFind.me")
	public String changePasswordFromFindPassword(@RequestParam("email") String email,
			@RequestParam("newPassword") String password, Model model, SessionStatus status) {
		// 비밀번호 암호화
		String encPassword = passwordEncoder.encode(password);
		Member member = new Member();
		member.setEmail(email);
		member.setPassword(encPassword);

		int result = ms.updatePasswordFromFind(member);
		if (result > 0) {
			status.setComplete();
			return "redirect:index.jsp";
		} else {
			return "common/errorPage";
		}
	}

	// 휴대폰 인증 - 세령
	/*
	 * @RequestMapping("confirmPhoneNumber.me") public void
	 * confirmPhoneNumber(@RequestParam("phone") String phone , HttpServletResponse
	 * response) {
	 * 
	 * int[] number = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}; String confirmNumber = "";
	 * for(int i = 0; i < 4; i++) { int random = (int) (Math.random() * 9);
	 * confirmNumber += random; }
	 * 
	 * String content = "[인증번호 : " + confirmNumber +
	 * "] Travel Interface에서 발송한 인증번호 입니다.";
	 * 
	 * String api_key = "NCSCVIJOV23Z5I7Y"; String api_secret =
	 * "GBCQMTJG7W59KFPRJQN91SXVSTLBULMA"; Coolsms coolsms = new Coolsms(api_key,
	 * api_secret);
	 * 
	 * Parameters 관련정보 : http://www.coolsms.co.kr/SDK_Java_API_Reference_ko#toc-0
	 * 
	 * HashMap<String, String> set = new HashMap<String, String>(); set.put("to",
	 * phone); // 수신번호 set.put("from", "01092260374"); // 발신번호 set.put("text",
	 * content); // 문자내용 set.put("type", "sms"); // 문자 타입
	 * 
	 * //JSONObject result = coolsms.send(set); // 보내기&전송결과받기
	 * 
	 * if (result.get("status") == true) { // 메시지 보내기 성공 및 전송결과 출력
	 * System.out.println("성공"); System.out.println(result.get("group_id")); //
	 * 그룹아이디 System.out.println(result.get("result_code")); // 결과코드
	 * System.out.println(result.get("result_message")); // 결과 메시지
	 * System.out.println(result.get("success_count")); // 메시지아이디
	 * System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수 } else {
	 * // 메시지 보내기 실패 System.out.println("실패");
	 * System.out.println(result.get("code")); // REST API 에러코드
	 * System.out.println(result.get("message")); // 에러메시지 }
	 * 
	 * 
	 * }
	 */
	
	 @ResponseBody
	 @RequestMapping("/sendSms")
	 public String sendSms(String receiver) {

	        // 6자리 인증 코드 생성
	        int rand = (int) (Math.random() * 899999) + 100000;

	        // 인증 코드를 데이터베이스에 저장하는 코드는 생략했습니다.

	        // 문자 보내기 
	        String hostname = "api.bluehouselab.com";
	        String url = "https://" + hostname + "/smscenter/v1.0/sendsms";

	        CredentialsProvider credsProvider = new BasicCredentialsProvider();
	        credsProvider.setCredentials(new AuthScope(hostname, 443, AuthScope.ANY_REALM),

	        // 청기와랩에 등록한 Application Id 와 API key 를 입력합니다.
	        new UsernamePasswordCredentials("TravelInterface", "979df3dea3f011e9b2910cc47a1fcfae"));

	        AuthCache authCache = new BasicAuthCache();
	        authCache.put(new HttpHost(hostname, 443, "https"), new BasicScheme());

	        HttpClientContext context = HttpClientContext.create();
	        context.setCredentialsProvider(credsProvider);
	        context.setAuthCache(authCache);

	        DefaultHttpClient client = new DefaultHttpClient();

	        try {
	            HttpPost httpPost = new HttpPost(url);
	            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
	            String content = "[인증번호 : " + rand + "] Travel Interface에서 발송한 인증번호 입니다.";
	            //문자에 대한 정보
	            String json = "{\"sender\":\"01092260374\",\"receivers\":[\""+receiver+"\"],\"content\":\""+content+"\"}";
	            
	            StringEntity se = new StringEntity(json, "UTF-8");
	            httpPost.setEntity(se);

	            HttpResponse httpResponse = client.execute(httpPost, context);

	            InputStream inputStream = httpResponse.getEntity().getContent();
	            if(inputStream != null) {
	                BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
	                String line = "";
	                while((line = bufferedReader.readLine()) != null)
	                    System.out.println(line);
	                inputStream.close();
	            }            
	        } catch (Exception e) {
                System.err.println("Error: " + e.getLocalizedMessage());
            } finally {
                client.getConnectionManager().shutdown();
            }
            return rand + "";
	    }
} // end class
