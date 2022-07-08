<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
	  <div class="modal" id="modalDropOutMember">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	      <header class="modal-card-head">
	        <p class="modal-card-title" style="padding-top:20px;">
	        	<i class="fas fa-check-square" style="color: #e74c3c; font-size: 30px;"></i> &nbsp;&nbsp;
	        	<strong>회원탈퇴안내</strong>
	        </p>
	        <button class="delete is-large" onclick="closeModal(3);"></button>
	      </header>
	      <section class="modal-card-body">
	        <div class="columns">
	        	<div class="column">
	        		<p>
	        			회원을 탈퇴할 경우 복구가 물가능 합니다. 탈퇴 후 사용자의 잔여 포인트가 모두 소실되며 회원 정보 및 서비스 이용기록은 모두 삭제되오니 신중하게 선택하여 주기시 바랍니다.
	        		</p>
	        	</div> <!-- end column -->
	        </div> <!-- end columns -->
	      </section>
	      <footer class="modal-card-foot" style="justify-content:flex-end;">
	        <a class="button is-danger" href="dropOutUser.me">회원탈퇴하기</a>
	        <a class="button" onclick="closeModal(3);">취소</a>
	      </footer>
	    </div>
	  </div>
</body>