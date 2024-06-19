<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp"/>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
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
  span {
  	color: white;
  }
</style>
<div class="insertForm">
	<h1 class="title">블로그 편집화면</h1>
	
	<form id="frm-blog-modify"
	      method="POST"
	      action="${contextPath}/anon/modifyAnon.do">
	
	  <div>
	    <span>작성자</span>
	    <span>${sessionScope.user.email}</span>
	  </div>
	  
	  <div>
	    <label for="title">제목</label>
	    <input type="text" name="title" id="title" value="${anon.title}">
	  </div>
	  
	  <div>
	    <textarea id="content" name="content" placeholder="내용을 입력하세요">${anon.content}</textarea>
	  </div>
	  
	  <div>
	    <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">
	    <input type="hidden" name="postNo" value="${anon.postNo}">
	    <button type="submit">수정완료</button>
	    <a href="${contextPath}/anon/list.page"><button type="button">작성취소</button></a>
	  </div>
	      
	</form>
</div>

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
          fetch('${contextPath}/anon/summernote/imageUpload.do', {
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