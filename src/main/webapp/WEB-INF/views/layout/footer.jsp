<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
  <footer class="main-footer">
    
  </footer>
  
  <script>
    var employeeNo = document.querySelector('input[name="employeeNo"]').value;
  
    document.addEventListener('DOMContentLoaded', () => {
    	document.querySelector('.drive a').addEventListener('click', (evt) => {
    		event.preventDefault();
    		checkDrive();
    	});
    });
    
    const checkDrive = () => {
    	fetch('${contextPath}/drive/checkDrive.do?employeeNo=' + employeeNo)
    	.then((response)=>response.json())
    	.then(resData=>{
    		if(resData.exists) {
    			window.location.href = '${contextPath}/drive/main.page';
    		} else {
    		  if(confirm('사용 중인 드라이브가 없습니다. 드라이브를 새로 만드시겠습니까?')) {
    			  createDrive();
    		  }
    		}
    	})
    	.catch(error => {
    		alert('드라이브 확인 중 오류가 발생했습니다.');
    	});
    }
    
    const createDrive = () => {
    	let folderName = 'drive';
    	let parentFolderNo = '';
    	
    	fetch('${contextPath}/drive/createFolder.do', {
    		method: 'POST',
    		headers: {
    			'Content-Type': 'application/json'
    		},
    		body: JSON.stringify({
    			'folderName': folderName,
    			'parentFolderNo': parentFolderNo,
    			'employeeNo': employeeNo,
    		})
      })
      .then((response)=>response.json())
    	.then(resData=>{
    			if(resData.insertCount === 1) {
    				alert('드라이브가 생성되었습니다.');
    				window.location.href = '${contextPath}/drive/main.page';
    			} else {
    				alert('드라이브 생성 실패했습니다.');
    			}
    	})
  		.catch(error => {
  			alert('드라이브 생성 중 오류가 발생했습니다.');
  		})
    }
    
  </script>

</body>
</html>


