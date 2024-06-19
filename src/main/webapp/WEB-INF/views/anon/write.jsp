<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp"/>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
  <script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">

<style>
  .insertForm {
    width: 1070px;
    padding: 20px;
    margin-left: 300px;
    margin-top: 30px;
    border: 1px solid gray;
    border-radius: 10px;
    background-color: #f9f9f9;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .insertForm > h1 {
    color: #333;
    text-align: center;
    margin-bottom: 20px;
  }
  .insertForm > div {
    margin-bottom: 15px;
  }
  .insertForm > div > span,
  .insertForm > div > label {
    color: #555;
    display: inline-block;
    width: 100px;
    font-weight: bold;
  }
  .insertForm > div > input[type="text"],
  .insertForm > div > textarea {
    width: calc(100% - 100px);
    padding: 5px;
    border-radius: 5px;
    border: 1px solid #ccc;
  }
  .insertForm > div > textarea {
    resize: vertical;
    height: 200px;
  }
  .insertForm > div > button,
  .insertForm > div > a > button {
    margin-top: 10px;
  }
  
  .title
  {
    margin-bottom: 10px;
  }
</style>

<div class="insertForm">
  <h1 class="title">익명게시판 작성화면</h1>

  <form id="frm-blog-register"
        method="POST"
        action="${contextPath}/anon/registerAnon.do">

    <div>
      <span>작성자 :</span>
      <span>익명</span>
    </div>

    <div class="title">
      <label for="title">제목 :</label>
      <input type="text" name="title" id="title">
    </div>

    <div>
      <textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
    </div>

    <div>
      <input type="hidden" name="authorNo" value="${sessionScope.user.employeeNo}">
      <button type="submit" class="btn btn-primary">작성완료</button>
      <a href="${contextPath}/anon/list.page">
        <button type="button" class="btn btn-secondary">작성취소</button>
      </a>
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
      onImageUpload: (images) => {
        for (let i = 0; i < images.length; i++) {
          let formData = new FormData();
          formData.append('image', images[i]);
          fetch('${contextPath}/anon/summernote/imageUpload.do', {
            method: 'POST',
            body: formData
          })
          .then(response => response.json())
          .then(resData => {
            $('#content').summernote('insertImage', '${contextPath}' + resData.src);
          })
        }
      }
    }
  })
}

const fnRegisterBlog = (evt) => {
  if (document.getElementById('title').value === '') {
    alert('제목 입력은 필수입니다.');
    evt.preventDefault();
    return;
  }
}

document.getElementById('frm-blog-register').addEventListener('submit', (evt) => {
  fnRegisterBlog(evt);
})

fnSummernoteEditor();
</script>

<%@ include file="../layout/footer.jsp" %>
