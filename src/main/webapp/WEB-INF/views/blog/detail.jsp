<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${blog.notiPostNo}번 블로그" name="title"/>
</jsp:include>

<!-- Bootstrap 스타일 및 스크립트 추가 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
  .blog-meta, .blog-content, .blog-actions, .blog-comment, .comment-form, .comment-list {
    margin-bottom: 20px;
  }
  .blog-meta span, .blog-content span {
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
  
  
</style>


<!-- 블로그 상세 내용을 담는 컨테이너 -->
  <section class="content">
		<div class="blog-container">
		  <!-- 블로그 제목 -->
		  <div class="blog-header">
		    <h1 class="title">공지사항 상세화면</h1>
		  </div>
		
		  <!-- 블로그 메타 정보 -->
		  <div class="blog-meta">
		    <span>작성자: ${blog.employee.name}</span>
		    <span>제목: ${blog.title}</span>
		  </div>
		
		  <!-- 블로그 내용 -->
		  <div class="blog-content">
		    <span>내용: </span>
		    <span>${blog.content}</span>
		  </div>
		
		  <!-- 블로그 수정 및 삭제 버튼 -->
		  <div class="blog-actions">
		    <c:if test="${sessionScope.user.employeeNo == blog.authorNo}"> <!--이게 현재 로그인된사람 번호랑 blog.authorNo 가 동일해야 밑에 편집삭제버튼이 보이는거지?ㅇㅇ근데 db상에는 알맞게 들어가있는데 호출이잘 안되고있음 그럼 거기아님? -->
		      <form id="frm-btn" method="POST">  
		        <input type="hidden" name="notiPostNo" value="${blog.notiPostNo}">
		        <button type="button" id="btn-edit-blog" class="btn btn-warning btn-sm">편집</button>
		        <button type="button" id="btn-remove-blog" class="btn btn-danger btn-sm">삭제</button>
		      </form>
		    </c:if>
		  </div>
		
		  <!-- 댓글 작성 폼 -->
		  <div class="blog-comments"> 
		    <hr>
		    <form id="frm-comment" class="comment-form">
		      <textarea id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
		      <input type="hidden" name="notiPostNo" value="${blog.notiPostNo}">
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
    frmBtn.attr('action', '${contextPath}/blog/editBlog.do');
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
      url: '${contextPath}/blog/registerComment.do',
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

// 전역 변수
var page = 1;

const categoryMap = {
	      0: '(대표실)',
	      1: '(행정부)',
	      2: '(인사팀)',
	      3: '(운영팀)',
	      4: '(강사팀)'
	  };

// 댓글/답글 목록
const fnCommentList = () => {
  $.ajax({
    type: 'get',
    url: '${contextPath}/blog/comment/list.do',
    data: 'notiPostNo=${blog.notiPostNo}&page=' + page,
    dataType: 'json',
    success: (resData) => {  // resData = {"commentList": [], "paging": "< 1 2 3 4 5 >"}
      console.log(resData.commentList);  
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
        let categoryName = categoryMap[comment.employee.departmentNo];
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
          str += '<span>' + categoryName + " : " +comment.employee.name + '</span>';
          str += '(' + moment(comment.commentDate).format('YY.MM.DD HH:mm') + ')';
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
          str += '    <input type="hidden" name="notiPostNo" value="${blog.notiPostNo}">';
          str += '    <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">';
          str += '    <textarea name="content" class="reply-content" placeholder="답글 입력"></textarea>';
          str += '    <button type="button" id="btnRegisterReply" class="btn btn-warning btn-register-reply">작성완료</button>';
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

/* // 답글 입력 창 보이기/숨기기
const fnSwitchingReplyInput = () => {
  $(document).on('click', '#replyBtn', (evt) => {
    fnCheckSignin();
    const divReplyInput = $(evt.target).next().next();
    if(divReplyInput.hasClass('blind')){
      $('#replyWrap').addClass('blind');
      divReplyInput.removeClass('blind');
    } else {
      divReplyInput.addClass('blind');
    }
  })
} */

const fnBtnReply = () => {
    $(document).on('click', '.btn-reply', (evt) => {
        $(evt.target).closest('.comment-start').find('.blind').toggle();
    });
}

// 답글 등록
const fnRegisterReply = () => {
  $(document).on('click', '#btnRegisterReply', (evt) => {
    fnCheckSignin();
    $.ajax({
      type: 'POST',
      url: '${contextPath}/blog/comment/registerReply.do',
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
      frmBtn.attr('action', '${contextPath}/blog/removeBlog.do');
      frmBtn.submit();
    }
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
      url: '${contextPath}/blog/removeComment.do',
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

$('#content').on('click', fnCheckSignin);
fnEditBlog();
$(document).on('click', '.reply-content', fnCheckSignin);
fnRegisterComment();
fnCommentList();
/* fnSwitchingReplyInput(); */
fnRegisterReply();
fnBtnReply();
fnModifyResult();
fnRemoveBlog();
fnRemoveComment();

</script>

<%@ include file="../layout/footer.jsp" %>