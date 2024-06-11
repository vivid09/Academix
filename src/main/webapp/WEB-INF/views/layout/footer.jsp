<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- sockjs-client 1.6.1 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 2.3.3 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>  

<script>
  $.widget.bridge('uibutton', $.ui.button);
  
  

  // 전역 stomp 클라이언트 설정
  let globalStompClient;
  
  const fnConnectGlobalStompClient = () => {
	  let employeeNo = ${sessionScope.user.employeeNo};
	  let globalSocket = new SockJS("/ws-stomp?employeeNo=" + employeeNo);
	  globalStompClient = Stomp.over(globalSocket); // STOMP 클라이언트 객체 저장
	  
	  
	  globalStompClient.connect({}, (frame) => {
		  
		  console.log('전역 소켓 연결 성공: ' + frame);
		  
		  globalStompClient.subscribe('/user/queue/notifications', (notification) => { // notification은 수신된 메시지를 가리키는 객체
			  
			  console.log('메시지 받음 >>> ', notification.body)
			  
			  const message = JSON.parse(notification.body);
			  fnShowAlert(message);
			  //showNotification(JSON.parse(notification.body));
		  }, {id: 'alert-' + ${sessionScope.user.employeeNo}});
	  }, function(error) {
		  console.log('WebSocket connection error: ' + error);
	  });
  };
  
/*    const showNotification = (message) => {
	    console.log('알림 표시 시도: ' + message);
 	    if (Notification.permission === 'granted') {
	        new Notification('New message', {
	            body: message,
	        });
	        console.log('알림 표시 완료');
	    } else if (Notification.permission !== 'denied') {
	        Notification.requestPermission().then(permission => {
	            if (permission === 'granted') {
	                new Notification('New message', {
	                    body: message,
	                });
	                console.log('알림 권한 획득 후 알림 표시 완료');
	            }
	        });
	    } 
	}; */
	
	
	// 알림 메시지 추가
 	const fnShowAlert = (notification) => {
 		
		/*
		{"notificationNo":4,
			"seenStatus":0,
			"employeeNo":6,
			"chatroomNo":2,
			"notifierNo":16,
			"message":"알림 테스트3\n",
			"notificationType":"CHAT",
			"notifierName":"김지현 강사",
			"notificationDate":"2024-06-11T06:26:48.562+00:00"
			} 
		*/
 		
		// 메시지 내용 : 송신자/내용 -> /기준으로 각각 파싱
		
		// 메시지 내용이 10자 이상이면 10글자까지만 추출해서 보여줌.
		let messageContent = notification.message;
		let senderName = notification.notifierName;
		let chatroomNo = notification.chatroomNo;
		
		if (messageContent.length > 15) {
			messageContent = messageContent.substring(0, 10) + '...';
		}
		
		let $menu = $('.alert-menu');
		// 받아온 메시지를 알림메시지에 추가한다.
		let msg = '';
		msg += '<li class="notification-item" data-chatroom-no="' + chatroomNo + '">';
		msg += '  <a href="#">';
		msg += '    <div class="pull-left">';
		msg += '      <img src="${contextPath}/resources/images/free-icon-star-1828884.png" class="img-circle" alt="User Image">';
		msg += '    </div>';
		msg += '    <h4>';
		msg += senderName;
		msg += '<small class="btn-removeMessageAlert"><i class="fa fa-times"></i></small>';
		msg += '    </h4>';
		msg += '    <p>' + messageContent + '</p>';
		msg += ' </a>';
		msg += '</li>';
		
		$menu.append(msg);
        <!-- start message -->
		
	}
 	
 	// 알림 메시지 가져오기
 	const fnGetNotificationList = () => {
 		
 		// employeeNo에 따른 알림 메시지 가져오기
 		let employeeNo = ${sessionScope.user.employeeNo};
 		fetch('${contextPath}/notification/getNotificationList.do?employeeNo=' + employeeNo, {
 			method: 'GET',
 		})
 		.then((response) => response.json())
 		.then(resData => {
 			
 			console.log('알림리스트', resData);
 			
 		})
 		
 		
 		
 	}
 	
 	
 	
	
	window.addEventListener('load', fnConnectGlobalStompClient);
	fnGetNotificationList();


	// btn-removeMessageAlert 에 삭제 함수 이벤트 걸어놓기
/*   const fnRemoveMessageAlert = () => {
	  
    document.addEventListener('click', (evt) => {
        if (evt.target.closest('.btn-removeMessageAlert')) {
        		evt.preventDefault();
        		evt.target.closest('.notification-item').remove();
        }
    });
  } */
  
  
  
  
  
  
</script>
  <footer class="main-footer">
    
  </footer>

</body>
</html>


