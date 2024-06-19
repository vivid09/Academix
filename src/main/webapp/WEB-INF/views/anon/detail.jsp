<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${anon.postNo}번 블로그" name="title"/>
</jsp:include>

<!-- Bootstrap 스타일 및 스크립트 추가 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<script src="./jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="./bootstrapt/css/bootstrap.min.css" />
	<link rel="stylesheet" href="./bootstrapt/css/bootstrap.css" />
	<script src="./bootstrapt/js/bootstrap.min.js"></script>



<!-- CSS 스타일링 -->
<style>

	.content {
	      min-height: 1080px;
	  }
	.main-footer{
	    margin-left: 20%;
	  }
	  
  .blog-container {
    max-width: 1070px;
    margin-left: 300px;
    margin-top: 30px;    
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #f9f9f9;
  }
  .blog-header {
    text-align: center;
    margin-bottom: 20px;
  }
  .blog-header h1 {
    font-size: 24px;
    color: #333;
  }
  .blog-meta, .blog-content, .blog-hit, .blog-actions, .blog-comment, .comment-form, .comment-list {
    margin-bottom: 20px;
  }
  .blog-meta span, .blog-hit, .blog-content span {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
  }
  .blog-meta span {
    color: #555;
  }
  .blog-actions .btn {
    margin-right: 5px;
  }
  .comment-form textarea {
    width: 100%;
    height: 100px;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
  }
  .comments-list .comment-item {
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
  }
  .comments-list .comment-item .comment-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
  }
  .comments-list .comment-item .comment-header span {
    font-size: 14px;
    color: #777;
  }
  .comments-list .comment-item .comment-header .comment-date {
    font-size: 12px;
    color: #aaa;
  }
  .comments-list .comment-item .comment-content {
    margin-bottom: 5px;
  }
  .btn-reply, .btn-remove-comment, .btn-register-reply {
    margin-top: 5px;
  }
  .div-frm-reply {
    padding-left: 20px;
    margin-top: 10px;
    border-left: 2px solid #ddd;
  }
  .blind {
    display: none;
  }
  
  .right-align {
  text-align: right;
}

.example-modal .modal {
  position: relative;
  top: auto;
  bottom: auto;
  right: auto;
  left: auto;
  display: block;
  z-index: 1;
}

.example-modal .modal {
  background: transparent !important;
}

.modal-content {
    position: relative;
    margin: 0 auto;
    text-align: left;
    background: #fff;
    width: 560px;
    overflow: hidden;
}

.modal-content .modal-header {
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    background: #fff;
    position: relative;
}

.modal-content .lst_report {
    padding: 0px 10px 0px;
    border-bottom: 1px solid #e6e6ea;
}

.modal-content .lst_report .report_area {
    padding-bottom: 10px;
}

.modal-content .lst_report dt {
    float: left;
    font-weight: bold;
    letter-spacing: -1px;
    font-size: 15px;
    letter-spacing: -0.5px;
    color: #929294;
}
.modal-content .lst_report .inner {
    display: block;
    min-width: 48px;
}

.modal-content .lst_report .report_nick {
    white-space: nowrap;
    text-overflow: ellipsis;
}
.modal-content .lst_report dd {
    overflow: hidden;
    position: relative;
    font-size: 15px;
    letter-spacing: -0.5px;
    color: #303038;
    padding-left: 8px;
}
.modal-content .lst_report dt, .modal-content .lst_report dd {
    padding-top: 10px;
    line-height: 20px;
}

.modal-content .lst_reason {
    padding: 0px 25px 0;
}

.modal-content .lst_reason .reason_title {
    display: block;
    padding-bottom: 11px;
    font-size: 16px;
    font-weight: bold;
    letter-spacing: -0.5px;
    color: #1e1e23;
}


.modal-content .lst_reason .list_type .list {
    position: relative;
    font-size: 16px;
    letter-spacing: -0.5px;
    color: #1e1e23;
    line-height: 21px;
    background: #fff;
}

.modal-content .report_reason {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}

.modal-content .lst_reason .list_type .list:first-child .check_area {
    border-radius: 6px 6px 0 0;
    margin-top: 0;
}
.modal-content .check_area {
    border: solid 1px #e6e6ea;
    padding: 15px 20px;
}

.modal-content .check_area label {
    position: relative;
    padding-left: 33px;
    padding-bottom: 1px;
    margin-right: 30px;
    display: block;
    vertical-align: middle;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.modal-content .check_area label:before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    background: url(https://ssl.pstatic.net/static/help/support/sp_ly_help.png) no-repeat -23px -1px;
    background-size: 95px 24px;
    width: 22px;
    height: 22px;
}
.modal-content .report_reason:checked + .check_area label:before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    background: url(https://ssl.pstatic.net/static/help/support/sp_ly_help.png) no-repeat 0 -1px;
    background-size: 95px 24px;
    width: 22px;
    height: 22px;
}

div {
    display: block;
    unicode-bidi: isolate;
}

.modal-content .btn_submit {
    display: block;
    background-color: #03c75a;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    width: 50%;
    height: 52px;
    line-height: 52px;
    text-align: center;
    border-radius: 6px;
    box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
    border: solid 0.5px rgba(0, 0, 0, 0.1);
}

.modal-content .btn-cancel {
    display: block;
    background-color: #03c75a;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    width: 50%;
    height: 52px;
    line-height: 52px;
    text-align: center;
    border-radius: 6px;
    box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
    border: solid 0.5px rgba(0, 0, 0, 0.1);
}

.modal-content .report-comments textarea {
    width: 100%;
    height: 100px;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.modal_footer {
    padding: 24px 30px 30px;
}

</style>


	<!-- 블로그 상세 내용을 담는 컨테이너 -->
	<section class="content">
	<div class="blog-container">
	  <!-- 블로그 제목 -->
	  <div class="blog-header">
	    <h1 class="title">익명게시판 상세화면</h1>
	  </div>
	
	  <!-- 블로그 메타 정보 -->
	  <div class="blog-meta">
	    <span>작성자: 익명</span>
	    <span>제목: ${anon.title}</span>
	    
	  </div>
	  
	  <!-- 블로그 메타 정보 -->
	  <div class="blog-hit">
	    <span>조회수 : ${anon.hit}</span>
	  </div>
	
	  <!-- 블로그 내용 -->
	  <div class="blog-content">
	    <span>내용: ${anon.content}</span>
	  </div>
	  
	
	  <!-- 블로그 수정 및 삭제 버튼 -->
	  <div class="blog-actions">
	    <c:if test="${sessionScope.user.employeeNo == anon.authorNo || sessionScope.user.employeeStatus == 2}"> 
	      <form id="frm-btn" method="POST">  
	        <input type="hidden" name="postNo" value="${anon.postNo}">
	        <input type="hidden" name="employeeStatus" value="${sessionScope.user.employeeStatus}">
	        <button type="button" id="btn-edit-blog" class="btn btn-warning btn-sm">편집</button>
	        <button type="button" id="btn-remove-blog" class="btn btn-danger btn-sm">삭제</button>
	      </form>
	    </c:if>
	    
		
	 <!-- 블로그 신고 버튼 -->
	<div class="blog-reports right-align">
	  <c:if test="${sessionScope.user.employeeNo != anon.authorNo}"> 
	      <button type="button" id="btn-reports-blog" class="btn btn-danger btn-sm">신고</button>
	  </c:if>
	</div>
	
	<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog" role="document">
	          <div class="modal-content">
	            <div class="modal-header">
	              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	              <h3 class="modal-title" id="exampleModalLabel">신고하기</h3>
	            </div>
	           	<div class="modal-body">
	           	  <div class="lst_report">
	           	    <dl class="report_area">
				              <dt><span class="inner">작성자</span></dt>
				              <dd class="report_nick"> 익명</dd>
				              <dt><span class="inner">제목</span></dt>
	                     <dd class="report_nick"> ${anon.title}</dd>
	                     <dt><span class="inner">내용</span></dt>
	                     <dd class="report_nick"> ${anon.content}</dd>
	           	    </dl>
				        </div> 			        
						</div>
	         <form id="frm-report">
			         <div class="lst_reason">
			                <strong class="reason_title">사유선택</strong>
			                  <div class="list_type">
			                    <ui style="list-style: none">
			                      <li class="list">
			                       <input type="radio" name="reportCategory" id="sel1" class="report_reason" value="1">
			                         <div class="check_area">
			                           <label for="sel1">스팸홍보/도배글입니다.</label>
			                         </div>
			                      </li>
			                      <li class="list">
			                       <input type="radio" name="reportCategory" id="sel2" class="report_reason" value="2">
			                         <div class="check_area">
			                           <label for="sel2">음란물입니다.</label>
			                         </div>
			                      </li>
			                      <li class="list">
			                           <input type="radio" name="reportCategory" id="sel3" class="report_reason" value="3">
			                         <div class="check_area">
			                           <label for="sel3">불법정보를 포함하고 있습니다.</label>
			                         </div>
			                      </li>
			                      <li class="list">
			                       <input type="radio" name="reportCategory" id="sel4" class="report_reason" value="4">
			                         <div class="check_area">
			                           <label for="sel4">불쾌한 표현이 있습니다.</label>
			                         </div>
			                      </li>
			                    </ui>
			                  </div>
			               </div>  
			           <div class="report-comments">
			           <hr>
			            <textarea id="report-content" name="description" placeholder="신고 사유 입력하세요"></textarea>
			           
			           </div>    
			               
	      			<input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">
	      			<input type="hidden" name="postNo" value="${anon.postNo}">
	    		</form>
	            <div class="modal-footer">
	                <a class="btn btn-danger btn-register-report w-50" id="report" href="#">신고하기</a>
	                <button class="btn btn-secondary w-50" type="button" data-dismiss="modal">취소</button>
	            </div>
	          </div>
	        </div>
	      </div>
		
	
			  <!-- 댓글 작성 폼 -->
			  <div class="blog-comments"> 
			    <hr>
			    <form id="frm-comment" class="comment-form">
			      <textarea id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
			      <input type="hidden" name="postNo" value="${anon.postNo}">
			      <c:if test="${not empty sessionScope.user}">  
			        <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">
			      </c:if>
			      <button type="button" id="btn-comment-register" class="btn btn-primary">댓글등록</button>
			    </form>
			  </div>
			
			  <!-- 댓글 목록 -->
			  <div class="comments-list" id="comment-list"></div>
			  <div id="paging"></div>
			</div>
  </div>
 </section>
 
		  <!-- jQuery 2.2.3 -->
		<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<!-- Bootstrap 3.3.6 -->
		<script src="/bootstrap/js/bootstrap.min.js"></script>
		<!-- jQuery UI 1.11.4 -->
		<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<!-- Slimscroll -->
		<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
		<!-- FastClick -->
		<script src="/plugins/fastclick/fastclick.js"></script>
		<!-- AdminLTE App -->
		<script src="/dist/js/app.min.js"></script>
	

	   <script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
	   <script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
	   <link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">

<script>

// 로그인 여부 체크
const fnCheckSignin = () => {
  if('${sessionScope.user}' === '') {
    if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
      location.href = '${contextPath}/user/signin.page';
    } else {
      return;
    }
  }
}

//블로그 편집 화면으로 이동
const fnEditBlog = () => {
  $('#btn-edit-blog').on('click', (evt) => {
    frmBtn.attr('action', '${contextPath}/anon/editAnon.do');
    frmBtn.submit();
  })
}

// 댓글 등록
const fnRegisterComment = () => {
  $('#btn-comment-register').on('click', (evt) => {
    fnCheckSignin();
    $.ajax({
      // 요청
      type: 'POST',
      url: '${contextPath}/anon/registerComment.do',
      data: $('#frm-comment').serialize(),  // <form> 내부의 모든 입력을 파라미터 형식으로 보낼 때 사용, 입력 요소들은 name 속성을 가지고 있어야 함
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"insertCount": 1}
        if(resData.insertCount === 1) {
          alert('댓글이 등록되었습니다.');
          $('#content').val('');
          location.reload();
          fnCommentList();
        } else {
          alert('댓글 등록이 실패했습니다.');
        }
      },
      error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
    })
    
  })
}

//신고 등록
const fnReport = () => {
  $('.btn-register-report').on('click', (evt) => {
    fnCheckSignin();
    $.ajax({
      // 요청
      type: 'POST',
      url: '${contextPath}/report/registerReport.do',
      data: $('#frm-report').serialize(),  // <form> 내부의 모든 입력을 파라미터 형식으로 보낼 때 사용, 입력 요소들은 name 속성을 가지고 있어야 함
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"insertCount": 1}
        if(resData.insertCount === 1) {
          alert('신고 완료.');
          $('#testModal').modal('hide'); // 신고 완료 후 모달 닫기
          location.reload();
        } else {
          alert('댓글 등록이 실패했습니다.');
        }
      },
      error: (jqXHR) => {
        alert("신고되었습니다."); // 수정 필요....
        $('#testModal').modal('hide'); // 신고 완료 후 모달 닫기
      }
    })
    
  })
}

// 전역 변수
var page = 1;
var comNo = '';

// 댓글/답글 목록
const fnCommentList = () => {
  $.ajax({
    type: 'get',
    url: '${contextPath}/anon/comment/list.do',
    data: 'postNo=${anon.postNo}&page=' + page,
    dataType: 'json',
    success: (resData) => {  // resData = {"commentList": [], "paging": "< 1 2 3 4 5 >"}
      const commentList = $('#comment-list');
      const paging = $('#paging');
      commentList.empty();
      paging.empty();
      if(resData.commentList.length === 0) {
        commentList.append('<div>첫 번째 댓글의 주인공이 되어 보세요</div>');
        paging.empty();
        return;
      }
      $.each(resData.commentList, (i, comment) => {
        let str = '';
        // 댓글은 들여쓰기 (댓글 여는 <div>)
        if(comment.depth === 0) {
          str += '<div class="comment-start" style="">';
        } else {
          str += '<div style="padding-left: 32px;">';
        }
        str += '<hr>';
        // 댓글 내용 표시
        if(comment.commentStatus === 0){
          str += '<div>삭제된 댓글입니다.</div>';
        } else {
          str += '<span>';
          if(${anon.authorNo} === comment.authorNo){
        	  str += '익명<span style="color:red;">(작성자)</span>';
        	  
          }else{
        	str += '익명';
          }
          str += '(' + moment(comment.commentDate).format('YYYY.MM.DD HH:mm:ss') + ')';
          str += '</span>';
          str += '<div>' + comment.content + '</div>';
          // 답글 버튼 (원글에만 답글 버튼이 생성됨)
          if(comment.depth === 0) {
            str += '<button type="button" id="replyBtn" class="btn btn-success btn-reply">답글</button>';
          }
          // 삭제 버튼 (내가 작성한 댓글에만 삭제 버튼이 생성됨)
          if(Number('${sessionScope.user.employeeNo}') === comment.authorNo) {
            str += '<button type="button" class="btn btn-danger btn-remove-comment" data-comment-no="' + comment.commentNo + '">삭제</button>';
          }
        }
        /************************ 답글 입력 화면 ************************/
       if(comment.depth === 0) {          
          str += '<div id="replyWrap" class="div-frm-reply blind">';
          str += '  <form class="frm-reply">';
          str += '    <input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
          str += '    <input type="hidden" name="postNo" value="${anon.postNo}">';
          str += '    <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">';
          str += '    <textarea name="content" class="reply-content" placeholder="답글 입력"></textarea>';
          str += '    <button type="button" class="btn btn-warning btn-register-reply">작성완료</button>';
          str += '  </form>';
          str += '</div>';
        }
        /****************************************************************/
        // 댓글 닫는 <div>
        str += '</div>';
        // 목록에 댓글 추가
        commentList.append(str);
      })
      // 페이징 표시
      paging.append(resData.paging);
    },
    error: (jqXHR) => {
      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
    }
  })
}

// 페이징
const fnPaging = (p) => {
  page = p;
  fnCommentList();
}


const fnBtnReply = () => {
    $(document).on('click', '.btn-reply', (evt) => {
        $(evt.target).closest('.comment-start').find('.blind').toggle();
    });
}


// 답글 등록
const fnRegisterReply = () => {
  $(document).on('click', '.btn-register-reply', (evt) => {
    fnCheckSignin();
    $.ajax({
      type: 'POST',
      url: '${contextPath}/anon/comment/registerReply.do',
      data: $(evt.target).closest('.frm-reply').serialize(),
      dataType: 'json',
      success: (resData) => {
        if(resData.insertReplyCount === 1) {
          alert('답글이 등록되었습니다.');
          $(evt.target).prev().val('');
          fnCommentList();
        } else {
          alert('답글 등록이 실패했습니다.');
        }
      },
      error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
    })
  })
}

// 전역 객체
var frmBtn = $('#frm-btn');



// 블로그 수정 결과 메시지
const fnModifyResult = () => {
  const modifyResult = '${modifyResult}';
  if(modifyResult !== '') {
    alert(modifyResult);
  }
}

// 블로그 삭제
const fnRemoveBlog = () => {
  $('#btn-remove-blog').on('click', (evt) => {
    fnCheckSignin();
    if(confirm('블로그를 삭제하면 모든 댓글이 함께 삭제됩니다. 삭제할까요?')){
      frmBtn.attr('action', '${contextPath}/anon/updatePostStatus.do');
      frmBtn.submit();
    }
  })
}

//조회수
const fnGetHitCountByPostNo = () => {
  let postNo = '${anon.postNo}';
  fetch('${contextPath}/anon/get-hit-count-by-postno?postNo=' + postNo,{
    method: 'GET',
  })
  .then(response => response.json())
  .then(resData => {
     let str = '<div>';
      str += '<span>' + resData.hitCount + '</span>'; // resData는 댓글 수를 나타냅니다.
      str += '</div>';
      const n = 1; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
      $('.figure-data-wrapper').find('.figure-data').eq(n).append(str);
  })
    .catch(error => {
      alert('Error getting hit count: ' + error); // 에러 처리
    })
}


// 댓글 삭제
const fnRemoveComment = () => {
  $(document).on('click', '.btn-remove-comment', (evt) => {
    fnCheckSignin();
    if(!confirm('해당 댓글을 삭제할까요?')){
      return;
    }
    $.ajax({
      // 요청
      type: 'post',
      url: '${contextPath}/anon/removeComment.do',
      data: 'commentNo=' + $(evt.target).data('commentNo'),
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"removeResult": "댓글이 삭제되었습니다."}
        alert(resData.removeResult);
        fnCommentList();
      }
    })
  })
}

const fnCheckStatus = () => {
	if(${anon.status == 0 || anon.status == 2}) {
		alert("삭제된 게시글입니다.");
    location.href = "${contextPath}/anon/list.page";
	} else {
		fnGetHitCountByPostNo();
	}
}

$('#content').on('click', fnCheckSignin);
fnCheckStatus();
fnEditBlog();
$(document).on('click', '.reply-content', fnCheckSignin);
fnRegisterComment();
fnCommentList();
fnRegisterReply();
fnBtnReply();
fnReport();
fnModifyResult();
fnRemoveBlog();
fnRemoveComment();

/* $('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').focus()
	})
 */
 $('#btn-reports-blog').click(function(e) {
	    e.preventDefault();
	    $('#testModal').modal("show");
	  });
	  
$('#sel1').click(function(e){
	console.log("선택값:: " + $('input[name=select]:checked').val())
})
	
</script>


<%@ include file="../layout/footer.jsp" %>