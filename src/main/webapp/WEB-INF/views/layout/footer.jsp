<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
  <footer class="main-footer">
    
  </footer>
  
  <script>
    var employeeNo = session.getAttribute("employeeNo");
  
    document.addEventListener('DOMContentLoaded', () => {
    	document.querySelector('.drive a').addEventListener('click', (evt) => {
    		event.preventDefault();
    		checkDrive();
    	});
    });
    
    const checkDrive = () => {
    	fetch('${contextPath}/drive/checkDrive?employeeNo=' + employeeNo)
    	.then(response => response.json())
    	.then(resData => {
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
    	let folderTitle = 'Drive';
    	let parentFolderNo = null;
    	
    	fetch('${contextPath}/drive/createFolder', {
    		method: 'POST',
    		headers: {
    			'Content-Type': 'application/json'
    		},
    		body: JSON.stringify({
    			'folderTitle': folderTitle,
    			'parentFolderNo': parentFolderNo,
    			'employeeNo': employeeNo
    		})
    		.then(response => response.json())
    		.then(resData => {
    			if(resData.success) {
    				alert('드라이브가 생성되었습니다.');
    				window.location.href = '${contextPath}/drive/main.page';
    			} else {
    				alert('드라이브 생성 실패했습니다.');
    			}
    		})
    		.catch(error => {
    			alert('드라이브 생성 중 오류가 발생했습니다.');
    		})
    	})
    }
    
  </script>

</body>
</html>


