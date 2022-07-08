<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
	  <div class="modal" id="modalAddExcelSpot">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	      <header class="modal-card-head">
	        <p class="modal-card-title" style="padding-top:20px;">엑셀로 여행지 추가</p>
	        <button class="delete is-large" onclick="closeModal();"></button>
	      </header>
	        		 <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="insertSpotExcel.sp" >
	      <section class="modal-card-body">
	        <div class="columns">
	        	<div class="column">
	        		 	  
	        		<div class="field">
				          <label class="file-label">
				            <input class="file-input" type="file" name="excelFile">
				            <span class="file-cta" style="background-color:#ffcc00;">
				              <span class="file-icon">
				                <i class="fa fa-upload"></i>
				              </span>
				              <span class="file-label"><b>엑셀 파일 첨부</b></span>
				            </span>
				            <span class="file-name" style="width:100%;">.xlsx, .xls</span>
				          </label>
				         <p style="margin-top:10px; color:gray;">등록할 엑셀파일을 첨부해 주세요. 엑셀파일의 데이터가 한번에 저장됩니다.</p>
				      </div>
	        	</div>
	        </div>
	      </section>
				       <footer class="modal-card-foot" style="justify-content:flex-end;">
					        <button class="button is-danger" type="submit">등록하기</button>
					      </footer>
				      </form>
	     <!--  <footer class="modal-card-foot">
	        <a class="button is-primary">엑셀파일로 여행지 추가</a>
	        <a class="button" onclick="closeModal();">취소</a>
	      </footer> -->
	    </div>
	  </div>
	  
	  <script>
	  	//모달 닫기용 함수
	  	function closeModal() {
	  		$("#modalAddExcelSpot").toggleClass('is-active');
	  	}
	  </script>
</body>