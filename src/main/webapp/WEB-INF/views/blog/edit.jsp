<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp"/>


<style>

	.content {
	      min-height: 1080px;
	  }
  .insertForm {
    width: 640px;
    height: 180px;
    margin: 10px auto;
    border: 1px solid gray;
    cursor: pointer;
  }
  .insertForm > insertForm {
    color: tomato;
    display: inline-block;
    box-sizing: border-box;
  }
</style>

<section class="content">

<div class="insertForm">
	<h1 class="title">블로그 편집화면</h1>
	
	<form id="frm-blog-modify"
	      method="POST"
	      action="${contextPath}/blog/modifyBlog.do">
	
	  <div>
	    <span>작성자</span>
	    <span>${sessionScope.user.email}</span>
	  </div>
	  
	  <div>
	    <label for="title">제목</label>
	    <input type="text" name="title" id="title" value="${blog.title}">
	  </div>
	  
	  <div>
	    <textarea id="content" name="content" placeholder="내용을 입력하세요">${blog.content}</textarea>
	  </div>
	  
	  <div>
	    <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">
	    <input type="hidden" name="notiPostNo" value="${blog.notiPostNo}">
	    <button type="submit">수정완료</button>
	    <a href="${contextPath}/blog/list.page"><button type="button">작성취소</button></a>
	  </div>
	      
	</form>
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

const fnSummernoteEditor = () => {
  $('#content').summernote({
    width: 1024,
    height: 500,
    lang: 'ko-KR',
    callbacks: {
      onImageUpload: (images)=>{
        // 비동기 방식을 이용한 이미지 업로드
        for(let i = 0; i < images.length; i++) {
          let formData = new FormData();
          formData.append('image', images[i]);
          fetch('${contextPath}/blog/summernote/imageUpload.do', {
            method: 'POST',
            body: formData
            /*  submit 상황에서는 <form enctype="multipart/form-data"> 필요하지만 fetch 에서는 사용하면 안 된다. 
            headers: {
              'Content-Type': 'multipart/form-data'
            }
            */
          })
          .then(response=>response.json())
          .then(resData=>{
            $('#content').summernote('insertImage', '${contextPath}' + resData.src);
          })
        }
      }
    }
  })
}

const fnModifyBlog = () => {
  document.getElementById('frm-blog-modify').addEventListener('submit', (evt) => {
    if(document.getElementById('title').value === '') {
      alert('제목 입력은 필수입니다.');
      evt.preventDefault();
      return;
    }
  })
}

fnSummernoteEditor();
fnModifyBlog();

</script>

<%@ include file="../layout/footer.jsp" %>