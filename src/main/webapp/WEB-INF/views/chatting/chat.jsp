<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="채팅" name="title"/>
 </jsp:include>

<link rel="stylesheet" href="${contextPath}/resources/css/chat.css?dt=${dt}">

<!-- Font Awesome 5.15.4 (unchanged as it's already the latest stable version for this specific major version) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

<!-- jsTree 3.3.12 (unchanged as it's the latest stable version) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />

<!-- jQuery 3.6.0 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- jQuery UI 1.12.1 (latest stable version) -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<!-- jsTree 3.3.12 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

<!-- sockjs-client 1.6.1 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 2.3.3 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>  
  
<script src="${contextPath}/resources/moment/moment-with-locales.min.js"></script>  
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        채팅
        <!-- <small>it all starts here</small> -->
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Examples</a></li>
        <li class="active">Blank page</li>
        <input type="hidden" data-session-no="${sessionScope.user.employeeNo}">
      </ol>
    </section>

    <!-- Main content -->
    <section class="content chat-content">

			<!-- 목록 화면 - 직원, 채팅목록 -->
      <!-- Default box -->
      <div class="box member-box">
         <div class="box-header with-border">
	         <div class="box-title-choice">
	           <i class="fa fa-user"></i>
	           <i class="fa fa-commenting"></i>
	         </div>
         
         	 <!-- 닫기 버튼이랑 메뉴 버튼 -->
	         <div class="box-tools pull-right">
	           <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
	             <i class="fa fa-minus"></i>
	           </button>
	         </div>
        </div>
        <div class="box-body chat-member"></div> 
      </div>
      
            <!-- 모달창 -->
      <div class="example-modal">
        <div class="modal fade" id="modal-default" style="display: none;">
          <div class="modal-dialog">
            <div class="modal-content">
              <!-- 이 부분 프로필 조회, 채팅방 이름 변경에 따라 동적 생성 -->
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">프로필 조회</h4>
              </div>
              <div class="modal-body chatModal-body">
              	<!-- 여기에 내용 넣으면 됨. -->
              	<div class="chat-modal-profile">
	              	<img src="/dist/img/user8-128x128.jpg" class="img-circle" alt="User Image">
	              	<p>이름</p>
	              	<span>부서</span>
	              	<div class="btn-oneToOneChat">
	              	  <i class="fa fa-commenting"></i>
	              	  <p class="selectUserNo">1:1 채팅</p>
	              	</div>
              	</div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      
      
      
      
      <!-- 채팅방 부분 -->
      <div class="chat-memberProfileList"></div>
      
      
      <div class="box chat-box" style="display: none">
        <div class="box-header with-border">
          <div class="chat-box-title">
						<span>채팅방 이름</span>
          </div>
          
          <!-- 상단 메뉴 -->
          <div class="box-tools pull-right">
            <!-- 드롭박스.. -->
	          <div class="dropdown">
						  <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="true">
						    <i class="fa fa-reorder"></i>
						  </a>
						  <div class="dropdown-menu chat-box-dropdown" aria-labelledby="dropdownMenuLink">
							  <table>
							    <tbody>
							      <tr class="title-row">
							        <td>현재 활동중</td>
							      </tr>
							      <tr class="employee-row">
							        <td>황수아 주임</td>
							        <td class="status offline">오프라인</td>
							      </tr>
							      <tr class="employee-row">
							        <td>정은비 수석</td>
							        <td class="status offline">오프라인</td>
							      </tr>
							      <tr class="employee-row">
							        <td>한다혜 사원</td>
							        <td class="status online">온라인</td>
							      </tr>
							      <tr class="employee-row">
	 						        <td>권태현 책임</td>
							        <td class="status offline">오프라인</td>
							      </tr>
 							      <tr class="employee-row">
	 						        <td><a href="#" class="leave-chat"><i class="fa fa-share"></i> 채팅방 나가기</a></td>
							        <td class="status offline"></td>
							      </tr>
							      
							    </tbody>
							  </table>
							  
						  </div>
						</div>
						<!-- 삭제 버튼(x) -->
<!-- 						<div class="remove-box">
							<a class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
							  <i class="fa fa-times"></i>
							</a>
						</div> -->
          </div>
        </div>
        <!-- 메시지 창 -->
        <div class="box-body chat-body">
        	<div class="chatMessage-body">
        	
        	
        		<!-- 여기에 메시지 추가 -->
        	
        	  <!-- 받은 메시지 -->
         	  <div class="chatMessage-you">
	        	  <div class="chatMessage-profile">
	        	    <img class="direct-chat-img" src="../dist/img/user1-128x128.jpg" alt="Message User Image">
	        	  </div>
	        	  <div class="chatMessage-main">
		        	  <div class="chatMessage-contents">
		        	    <div class="chatMessage-senderName">정은비 수석</div>
		        	    <div class="chatMessage-content">안녕하세요 지훈님. 혹시 오늘 회의록 정리해서 올려주실 수 있나요?</div>
		        	  </div>
		        	  <div class="chatMessage-info">
		        	    <span class="hit-count">2</span>
		        	    <span class="chatMessage-time">오후 18:30</span>
		        	  </div>
	        	  </div>
        	  </div>
        	  <!-- 받은 메시지 끝 -->
        	  
        	  <!-- 보낸 메시지 -->
          	  <div class="chatMessage-me">
	        	  <div class="chatMessage-main">
		        	  <div class="chatMessage-contents">
		        	    <div class="chatMessage-content">
		        	    그나저나 너는 요즘 어떤 일들을 하고 있어? 새로 시작한 취미나, 
									최근에 읽은 책, 혹은 관심 갖게 된 주제 같은 게 있니? 
									예전엔 우리가 서로 이런저런 이야기 나누면서 시간을 보내곤 
									했는데, 지금도 그때가 그리워. 때론 바쁜 일상 속에서 소중한
									 사람들과의 대화가 큰 위로가 되잖아.
									</div>
		        	  </div>
		        	  <div class="chatMessage-info">
		        	    <span class="hit-count">2</span>
		        	    <span class="chatMessage-time">오후 18:30</span>
		        	  </div>
	        	  </div>
        	  </div> 
        	  <!-- 보낸 메시지 끝 -->

        	  
        	</div>
        	<!-- 입력창 -->
         	<div class="chatMessage-input">
	        	<input class="form-control chat-message-input" type="text" maxlength='500' placeholder="Default input">
	        	<button type="submit" class="btn btn-primary chatMessage-btn"><i class="fa fa-send"></i></button>
        	</div>
        </div>      
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  
  
  <script>
  
  // stomp 연결 전역 객체
	let stompClient = null;  
  
  // 무한 스크롤 페이지
  let page = 1;
	let chatMessageTotalPage = 0;
	let gChatroomNo = 0;
	//let previousScrollHeight = 0;
	//let previousScrollTop = 0;
	
	
	// 입력 데이터 날짜 생성
	let gPreviousDate = null;
	
	// 날짜 한글로
	moment.locale('ko');
	
	
	
  // 직원 목록 & 채팅 목록 조회
  const fnShowChatList = () => {
	  
	  // 첫번째 사람 아이콘 클릭 시
	  $('.box-title-choice i').eq(0).on('click', () => {
		  $('.chat-member').empty();
		  $('.box-title-choice i').eq(1).css('color', '#B5B5B5');
		  $('.box-title-choice i').eq(0).css('color', 'black');
		  $('.chat-member .chat-member-title').text('직원 목록');
		  $('.chat-member .chat-member-title').remove();
      $('.chat-member .searchInput').remove();
      $('.chat-member #memberArea').remove();
		  fnGetChatUserList();
	  })
	  
	  // 두번째 채팅 아이콘 클릭 시
	  $('.box-title-choice i').eq(1).on('click', () => {
		  $('.box-title-choice i').eq(0).css('color', '#B5B5B5');
		  $('.box-title-choice i').eq(1).css('color', 'black');
      // input 태그 삭제
      $('.chat-member .searchInput').remove();
      // #memberArea div 요소 삭제
      $('.chat-member #memberArea').remove();
      $('.chat-member .chat-member-title').text('채팅 목록');
      
      // 
      $('.chat-member-title').after('<ul class="contacts-list"></ul>');
      
      
      
      
      
      // 채팅 목록 가져오기
      fnGetChatList(${sessionScope.user.employeeNo});
      // 채팅 클릭 시..
      //fnGochatroom();
      
      
	  })
	  
  }

  // 직원 리스트 가져오기
  const fnGetChatUserList = () => {
	  
 	  // 새로운 태그 추가
    $('.chat-member').append('<p class="chat-member-title">직원 목록</p>');
    $('.chat-member').append('<input type="text" class="searchInput" placeholder="직원 검색">')
    $('.chat-member').append('<div id="memberArea"></div>');
	  
	  fetch('${contextPath}/user/getUserList.do',{
	      method: 'GET',
	    })
		.then((response) => response.json())
	  .then(resData => {
		
		  // 변환한 데이터 담을 배열 선언
		  var jstreeData = [];
		  
		  
		  // 회사 root node로 설정
		  var com = resData.departments.find(depart => depart.departName === 'Academix');
		  if(com) {
			  jstreeData.push({
				  id: com.departmentNo,
				  parent: '#',
				  text: com.departName,
				  icon: "fas fa-building"
			  });
		  }
		  
		  // employee 데이터에서 대표데이터만 빼서 설정
		  var ceo = resData.employee.find(employee => employee.rank.rankTitle === '대표이사');
		  if(ceo) {
			  jstreeData.push({
				  id: 'emp_' + ceo.employeeNo,
				  parent: '0',
				  text: ceo.name + ' ' + ceo.rank.rankTitle,
				  icon: "fas fa-user-tie"
			  });
		  }
		  
		  // 부서 데이터
		  resData.departments.forEach(function(department) {
			  if(department.departName !== 'Academix'){
				  jstreeData.push({
					  id: department.departmentNo.toString(),
					  parent: department.parentDepartNo.toString(),
					  text: department.departName,
					  icon: "fas fa-layer-group"
				  });
			  }
		  });
		  
		  // 직원 데이터
		  resData.employee.forEach(function(employee) {
			  if(employee.depart.departmentNo !== 0 && employee.employeeStatus !== 0){ // 대표이사 제외
				  if(employee.rank.rankNo === 5) {
	     		  jstreeData.push({
	     			  id: 'emp_' + employee.employeeNo,
	     			  parent: employee.depart.departmentNo.toString(),
	     			  text: employee.name + ' ' + employee.rank.rankTitle,
	     			  icon: "fas fa-chalkboard-teacher"
	     		  });
				  } else {
       		  jstreeData.push({
       			  id: 'emp_' + employee.employeeNo,
       			  parent: employee.depart.departmentNo.toString(),
       			  text: employee.name + ' ' + employee.rank.rankTitle,
       			  icon: "fas fa-user"
       		  });
				  }
			  }
		  });
		  
		  // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
		  $('#memberArea').jstree({
			  'core': {
				  'data': jstreeData,
		        'themes': {
		           'icons': true
		        }
			  },
			  'plugins': ['search', 'checkbox'],
		   		  'checkbox': {
				       'keep_selected_style': true,
				       'three_state': false,
				       'whole_node' : false,
				       'tie_selection' : false,
				       'cascade': 'down'
				    }      		  
		  }).on('ready.jstree', function() {
			  $(this).jstree(true).open_all();
		  })
		  
	    // 검색 기능 추가
	    $('.searchInput').on('keyup', function() {
	  	  var searchString = $(this).val();
	  	  $('#memberArea').jstree('search', searchString);
	    });
		  
	  })
	  .catch(error => {
	    console.error('There has been a problem with your fetch operation:', error);
	  });  
	  
	  fnGetProfile();
	  
  }
  
  // 프로필 조회하기
  const fnGetProfile = () => {
	  
	  $('#memberArea').bind('select_node.jstree', function(event, data) {
		  var selectedNode = data.node;
		  var employeeNo;
		  
		  // id가 0인 경우 -> Academix
		  // id가 emp를 포함하는 경우 -> 그대로..
		  // 그외 -> return
		  if(selectedNode.id.includes('emp_')) {
			  employeeNo = selectedNode.id.replace('emp_', '');
		  } else {
			  return;
		  }
		  

		  fetch('${contextPath}/user/getUserProfileByNo.do?employeeNo=' + employeeNo,{
		      method: 'GET',
		    })
			.then((response) => response.json())
		  .then(resData => {
			  
			  /*
			  
			  {
			    "employee": {
			        "employeeNo": 8,
			        "employeeStatus": 1,
			        "name": "권태현",
			        "email": "taehyun.kwon@example.com",
			        "phone": "010-8901-2345",
			        "address": "서울특별시",
			        "password": "03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4",
			        "profilePicturPath": null,
			        "hireDate": "2024-06-01",
			        "exitDate": "2024-06-01",
			        "depart": {
			            "departmentNo": 3,
			            "parentDepartNo": 1,
			            "departName": "운영팀"
			        },
			        "rank": {
			            "rankNo": 2,
			            "rankTitle": "책임"
			        }
			    }
				}
			  */
    	  
    	  $('.chat-modal-profile > p').text(resData.employee.name);
    	  $('.chat-modal-profile > span').text(resData.employee.depart.departName);
    	  $('.selectUserNo').attr('data-user-no', resData.employee.employeeNo);
    	  $('.selectUserNo').data('user-no', resData.employee.employeeNo);
    	  /* $('.selectUserNo').data('userNo', resData.employee.employeeNo); */
    	  $('#modal-default').modal('show');
		  })
		  .catch(error => {
		    console.error('There has been a problem with your fetch operation:', error);
		  });
	  })
  }
  
  // 채팅방 조회 및 생성(1:1)
	const fnAddChatRoom = () => {
		
		// 모달창의 1:1 채팅 아이콘 클릭시..
	  $('.btn-oneToOneChat > i').on('click', () => {
		  $('.chat-memberProfileList').empty();
		  // fetch로 현재 세션번호와 해당 노드의 직원 번호를 보내서 chatroom_t에 데이터 있는지 확인
		  // 조건 1. CHATROOM_TYPE='OneToOne' (1:1 이므로)
		  // 조건 2. CREATOR_NO가 로그인 유저 혹은 선택한 직원 번호임.

		  page = 1;
		  chatMessageTotalPage = 0;
		  
		  // 유저가 선택한 직원의 번호
		  let chatUserNo = $('.selectUserNo').data('user-no');
		  
		  if(${sessionScope.user.employeeNo} === chatUserNo) {
			  return;
		  }
		  
		  fetch('${contextPath}/chatting/isOneToOneChatroomExits.do?loginUserNo=' + ${sessionScope.user.employeeNo} + '&chatUserNo=' + chatUserNo,{
		      method: 'GET',
		    })
			.then((response) => response.json())
		  .then(resData => { 
				  console.log(resData);
				  /*
				  resData
				  {
				    "chatroom": {
				        "chatroomNo": 1,
				        "creatorNo": 0,
				        "chatroomTitle": "채팅방1",
				        "chatroomCreatedDate": "2024-05-31T03:20:53.022+00:00"
				    }
					}
				  */
    	  
    	    // 만약 resData.chatroom.chatroomNo값이 0이라면 채팅방이 없다는 뜻이므로 새로 만든다.
    	    // 1. fetch로 서버에게 로그인 유저번호와 chatUserNo 보낸다.
    	    
    	    if(resData.chatroom.chatroomNo === 0) { // 채팅방 없음.
		    	  fetch('${contextPath}/chatting/insertNewOneToOneChatroom.do', {
		    		  method: 'POST',
		    		  headers: {
	    			    "Content-Type": "application/json",
	    			  },
		    		  body: JSON.stringify({
		    			  loginUserNo: ${sessionScope.user.employeeNo},
		    			  chatUserNo: chatUserNo
		    		  })
		    	  })
		    	  .then((response) => response.json())
		    	  .then(resData => {
		    		  /*
		    		  {
						    "chatroom": {
						        "chatroomNo": 6,
						        "creatorNo": 0,
						        "chatroomTitle": "김의정, 윤동현",
						        "chatroomType": "OneToOne",
						        "chatroomCreatedDate": "2024-06-01T04:16:00.060+00:00"
						    },
						    "insertOneToOneCount": 1
							}
		    		  */
		    		  // 필요한 데이터 : 성공응답, 새로 만든 chatroom
		    		  
		    		  let chatroomNo = resData.chatroom.chatroomNo;
		    		  gChatroomNo = resData.chatroom.chatroomNo;
		    		  
		    		  if(resData.insertOneToOneCount === 1) { // 방 새로 만들기 성공
		    			  
		    			  const employeeList = [${sessionScope.user.employeeNo}, chatUserNo];
		    			  //$('.chat-memberProfileList').empty();
		    			  fetchSenderUserData(employeeList);
		    		  
		    			  // 채팅방 열기
		    			  fnOpenChatroom(resData.chatroom);
		    			  
		    		 	  const chatBox = $('.chat-body'); 
		    		 	  chatBox.scrollTop(chatBox.prop('scrollHeight'));
			    			  
		    			  
		    		  } else {
		    			  alert('새로고침 해주세요..1:1 방 만들기 실패');
		    		  }
		    	  })
    	    	
    	    } else { // 채팅방 존재함.
    	    	
    	    	let chatroomNo = resData.chatroom.chatroomNo;
    	    	gChatroomNo = resData.chatroom.chatroomNo;
    	    	
    	    	const employeeList = [${sessionScope.user.employeeNo}, chatUserNo];
    	    	fetchSenderUserData(employeeList);
    	    
						// 채팅방 열기
    	    	fnOpenChatroom(resData.chatroom);

    	    	
    	    }
		  })
		  .catch(error => {
		    console.error('There has been a problem with your fetch operation:', error);
		  });
	  })
  } 
	

	
	// STOMP 연결
 	const fnConnect = (chatroomType) => {
		let socket = new SockJS("/ws-stomp");
		stompClient = Stomp.over(socket);
		stompClient.connect({}, (frame) => {
			//setConnected(true); 오프라인 -> 온라인 변경(혹은 그냥 세션에 해당 번호 있는걸로 판단.)
			console.log('소켓 연결 성공: ' + frame);
			
			let chatroomNo = $('.chat-box-title').data('chatroom-no');  // (1)
			
			// 저장된 채팅 불러오기
			fnGetChatMessage(chatroomNo);  // (2)
			
			
			if(chatroomType === 'OneToOne') {  // (4) 끝까지
				// 구독
				console.log('구독되었습니다.');
				stompClient.subscribe('/topic/' + chatroomNo, (chatroomMessage) =>{
					console.log('받은 메시지: ' + JSON.stringify(JSON.parse(chatroomMessage.body)));
					
					// 받은 메시지 보여주기
					fnShowChatMessage(JSON.parse(chatroomMessage.body));
					
					
					

				})
			} // elsel로 chatroomType이 group일때는 /queue 처리
		})
	} 
 	
 	// STOMP 연결 끊기
 	const fnDisconnect = () => {
 		if(stompClient !== null) {
 			stompClient.disconnect();
 		}
 		// 상태 오프라인 설정
 		console.log('disconnect');
 		
 	}
	
	// 메시지 전송
 	const fnSendChat = () =>{
		if($('.chat-message-input').val() != '') {
			
			let chatroomNo = $('.chat-box-title').data('chatroom-no');
			
			stompClient.send("/send/" + chatroomNo, {},
					JSON.stringify({
						'chatroomNo': chatroomNo,
						'messageType': 'CHAT',
						'messageContent': $('.chat-message-input').val(),
						'isRead': 0,  // 임시임..
						'senderNo': ${sessionScope.user.employeeNo}
					}));
			console.log('보낸 메시지: ' + $('.chat-message-input').val())
			$('.chat-message-input').val('');
		}
	}
 	
 	// 전송 버튼 누르면 메시지 전송됨.
 	//const fnMessageSend = () => {
 		$('.chatMessage-btn').on('click', () => {
 			fnSendChat();
 		})
 	//}
 	
 	// 엔터 누르면 전송 버튼 눌려지게 하기
 	const fnPressEnterSendBtn = () => {
 		let input = $('.chat-message-input');
 		input.on('keyup', (evt) => {
 			if(evt.keyCode === 13) {
 				evt.preventDefault();
 				$('.chatMessage-btn').click();
 			}
 		})
 	}
 	
 	// 날짜 비교 함수
 	const isSameDay = (date1, date2) => {
	  const d1 = new Date(date1);
	  const d2 = new Date(date2);
	  return d1.getFullYear() === d2.getFullYear() &&
	         d1.getMonth() === d2.getMonth() &&
	         d1.getDate() === d2.getDate();
	};
	
	// 프론트에 있는 유저 데이터 가져오기
	const getEmployeeData = (employeeNo) => {  // (12) - 함수 생성
		
		const input = $('input[data-employee-no=' + employeeNo + ']');
	  if (input.length > 0) {
	    const employeeName = input.attr('data-employee-name');
	    const profilePicturePath = input.attr('data-employee-profilePicturePath');
	    return {
	      employeeNo: employeeNo,
	      name: employeeName,
	      profilePicturePath: profilePicturePath
	    };
	  } else {
	    return null; // 해당 employeeNo의 데이터가 없을 경우
	  }
	};
	
	// 전송자 번호 및 내가 보낸 번호로 유저 데이터 가져오기
	const fetchSenderUserData = (senderNoList) => {  // (11) - 함수 생성
		return fetch('${contextPath}/user/getUserProfileListByNo.do', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({employeeNoList: senderNoList}) // 유저 번호 JSON으로 전송 // (15) - fetch 실행
		})
		.then((response) => response.json())
		.then(resData => {
			
			const employeeList = resData.employeeList;
			
			//$('.chat-memberProfileList').empty();
			// 데이터를 돌면서 회원 데이터 담은 input 추가
			employeeList.forEach(resData => {
				const hiddenInputHTML = '<input type="hidden" data-employee-no="' + resData.employeeNo + '" data-employee-name="' + resData.name + ' ' + resData.rank.rankTitle + '" data-employee-profilePicturPath="' + resData.profilePicturPath + '">';
				
				const chatMemberProfileList = $('.chat-memberProfileList');
				
		    if (chatMemberProfileList.length) {
		        chatMemberProfileList.append(hiddenInputHTML);
		        //console.log('.chat-memberProfileList after append: ', chatMemberProfileList.html());
		    } else {
		        console.error('.chat-memberProfileList element not found');
		    } 						
			})
		});
	};	
		

	// 메시지 프로필 설정
	const SetEmployeeMessageProfile = (chatMessageList) => { // (13) - 함수 생성
		const messagePromises = chatMessageList.map(message => {
			return new Promise((resolve) => { // (23)
				
				let messageHTML = ''; // (17)   (24)
				
				// chatMessageList를 반복문으로 돌면서 하나씩 번호를 비교한다.
					if(message.senderNo === ${sessionScope.user.employeeNo}) { // (18)
						// 내가 보낸 메시지인 경우,
					
						// 해당 회원의 데이터를 가져옴.
						const senderData = getEmployeeData(message.senderNo);
						
						// 만약 가져온 데이터가 있다면..
						if(senderData) { // (20)
							messageHTML += '<div class="chatMessage-me">';
							messageHTML += '  <div class="chatMessage-main">';
							messageHTML += '    <div class="chatMessage-contents">';
							messageHTML += '      <div class="chatMessage-content">' + message.messageContent + '</div>';
							messageHTML += '    </div>';
						  messageHTML += '    <div class="chatMessage-info">';
						  messageHTML += '      <span class="chatMessage-time">' + moment(message.sendDt).format('A hh:mm') + '</span>';
						  messageHTML += '    </div>';
						  messageHTML += '  </div>';
						  messageHTML += '</div>';
						}
					} else {
						// 아닌 경우에는 프로필번호를 가지고 와서 그거에 맞는 값 가져옴.
						
						// 해당 회원의 데이터를 가져옴.
						const senderData = getEmployeeData(message.senderNo); // (19)
						
						// 만약 가져온 데이터가 있다면..
						if(senderData) {
							messageHTML += '<div class="chatMessage-you">';
							messageHTML += '  <div class="chatMessage-profile">';
							messageHTML += '    <img class="direct-chat-img" src="../dist/img/user1-128x128.jpg" alt="Message User Image">';
							messageHTML += '  </div>';
							messageHTML += '  <div class="chatMessage-main">';
							messageHTML += '    <div class="chatMessage-contents">';
							messageHTML += '      <div class="chatMessage-senderName">' + senderData.name + '</div>';
							messageHTML += '      <div class="chatMessage-content">' + message.messageContent + '</div>';
							messageHTML += '    </div>';
							messageHTML += '    <div class="chatMessage-info">';
							messageHTML += '      <span class="chatMessage-time">' + moment(message.sendDt).format('A hh:mm') + '</span>';
							messageHTML += '    </div>';
							messageHTML += '  </div>';
							messageHTML += '</div>';
						}
					}
				
				resolve({ // (21)
					sendDt: message.sendDt,
					html: messageHTML
				});
			}); // (22)
		});
		
		Promise.all(messagePromises)
			.then(messages => {
			let messageList = '';
			let previousDate = null;
			
			messages.forEach((messageObj) => {
				
				const messageDate = new Date(messageObj.sendDt);
				
        if (previousDate && !isSameDay(previousDate, messageDate)) {
           const dateString = moment(messageDate).format('YYYY년 MM월 DD일');
           messageList += '<div class="date-divider">' + dateString + '</div>';
         }
        
        messageList += messageObj.html;
        previousDate = messageDate;
			});
			
      $('.chatMessage-body').prepend(messageList);
      
		  // 무한 스크롤 실행 전 스크롤 위치 저장
		  //const chatContainer = $('.chat-body'); 
	    //previousScrollHeight = chatContainer.prop('scrollHeight');
	    //previousScrollTop = chatContainer.scrollTop();
      
	    // 처음 메시지 데이터 불러올때만 스크롤 맨 아래로, 그 다음부터는 위치 유지
	    if(page === 1) {
	      const chatBox = $('.chat-body'); 
	      chatBox.scrollTop(chatBox.prop('scrollHeight'));
	    } else {
	      //const chatBox = $('.chat-body'); 
	      //chatBox.scrollTop(chatBox.prop('scrollHeight')*0.1);
	    }
	})
   .catch(error => {
     console.error('Error processing messages:', error);
   });
	};		
		
		
		
		
		
		
		
		
	
 	// 채팅 내역 가져오기
 	const fnGetChatMessage = (chatroomNo) => { 
 		
 		fetch('${contextPath}/chatting/getChatMessageList.do?chatroomNo=' + chatroomNo + '&page=' + page, {  // (3)
 			method: 'GET',
 		})
 		.then((response) => response.json())  // (5) - 아까 위의 fetch로 받아온 데이터 json 파싱 
 		.then(resData => {
 			
 			// 무한 스크롤용 totalPage
 			chatMessageTotalPage = resData.chatMessageTotalPage;  // (7)
 			
 			// 메시지 객체 담은 리스트
 			const chatMessageList = resData.chatMessageList.reverse(); // (8)
 			
 			// 전역 gPreviousDate에 제일 최신 날짜 값 넣기
      if (chatMessageList.length > 0) {
          const latestMessage = chatMessageList[chatMessageList.length - 1];
          gPreviousDate = new Date(latestMessage.sendDt);
      } else {
          const today = new Date();
          gPreviousDate = today.toLocaleString();
      }      
 			
 			// 메시지에 해당하는 senderNo 리스트로 받기(모든 회원)
 			
 			
 			//const senderNoList = Array.from(new Set(chatMessageList.map(message => message.senderNo)));  // (9)
 			
 			let messageList = '';  // (10)
 			
 			// 여기서 해당 채팅방의 회원데이터를 input으로 넣어야 함.
 			// 1. fetchSenderUserData(회원 리스트 실행);
 			//$('.chat-memberProfileList').empty();
 			
				fnGetParticipantsNoList(chatMessageList[0].chatroomNo)
				.then(senderNoList => {
				fetchSenderUserData(senderNoList);
				//fnGetChatMessage(chatroomDto.chatroomNo);
			})
 			
      SetEmployeeMessageProfile(chatMessageList); // (16)

      
 		})
 		.catch(error => {
 			console.error('Error fetching sender data:', error);
 		});
 		
 	};
 	
 	// 채팅방 열기
 	const fnOpenChatroom = (chatroomDto) => {
 		
    	// 채팅방 화면 display:none 없애기
    	$('.chat-box').css('display', '');
	  
		    // 채팅방 이름 변경
    	$('.chat-box-title > span').text(chatroomDto.chatroomTitle);
		    
		    // 채팅방 번호 data 속성 추가
    	$('.chat-box-title').attr('data-chatroom-no', chatroomDto.chatroomNo);
   	  $('.chat-box-title').data('chatroom-no', chatroomDto.chatroomNo);
   	  
   		// 모달창 닫기
   	  $('#modal-default').modal('hide');
   		
   		// 채팅방 전 데이터 삭제
	    let chatMessageBody = $('.chatMessage-body');
	    chatMessageBody.empty();
   		
   	  fnDisconnect();
   		
   		// stomp 연결
   	  fnConnect(chatroomDto.chatroomType);
   		

 		
 	}
 	
 	
 	// 채팅 메시지 보기
 	// 이 함수는 전송 버튼을 눌렀을 때 실행이 되어야 하나..?
 	const fnShowChatMessage = (chatMessage) => {
 		
 		// 기본적으로 채팅 메시지 가져올때는 prepend로 앞에다 붙여주는데 메시지 보냈을 때는 끝에 붙여줘야 하니까..
 		
		if(chatMessage.senderNo === ${sessionScope.user.employeeNo}) { 
			// 내가 보낸 메시지인 경우,
			 		
 		  // 메시지 작성자의 번호를 통해 input 데이터 가져오기
 		  const senderData = getEmployeeData(chatMessage.senderNo);
			
			// 날짜 추가
			const messageDate = new Date(chatMessage.sendDt);
			
      if (gPreviousDate && !isSameDay(gPreviousDate, messageDate)) {
        const dateString = moment(messageDate).format('YYYY년 MM월 DD일');
        $('.chatMessage-body').append('<div class="date-divider">' + dateString + '</div>');
      }
      
      gPreviousDate = messageDate;
		
			// 만약 가져온 데이터가 있다면..
			if(senderData) { // (20)
				let messageHTML = '';				
				messageHTML += '<div class="chatMessage-me">';
				messageHTML += '  <div class="chatMessage-main">';
				messageHTML += '    <div class="chatMessage-contents">';
				messageHTML += '      <div class="chatMessage-content">' + chatMessage.messageContent + '</div>';
				messageHTML += '    </div>';
			  messageHTML += '    <div class="chatMessage-info">';
			  messageHTML += '      <span class="chatMessage-time">' + moment(chatMessage.sendDt).format('A hh:mm') + '</span>';
			  messageHTML += '    </div>';
			  messageHTML += '  </div>';
			  messageHTML += '</div>';
			  $('.chatMessage-body').append(messageHTML);
			}
			
		} else {
			// 아닌 경우에는 프로필번호를 가지고 와서 그거에 맞는 값 가져옴.
			 		
	 		// 메시지 작성자의 번호를 통해 input 데이터 가져오기
	 		const senderData = getEmployeeData(chatMessage.senderNo);
			
			// 만약 가져온 데이터가 있다면..
			if(senderData) {
				let messageHTML = '';
				messageHTML += '<div class="chatMessage-you">';
				messageHTML += '  <div class="chatMessage-profile">';
				messageHTML += '    <img class="direct-chat-img" src="../dist/img/user1-128x128.jpg" alt="Message User Image">';
				messageHTML += '  </div>';
				messageHTML += '  <div class="chatMessage-main">';
				messageHTML += '    <div class="chatMessage-contents">';
				messageHTML += '      <div class="chatMessage-senderName">' + senderData.name + '</div>';
				messageHTML += '      <div class="chatMessage-content">' + chatMessage.messageContent + '</div>';
				messageHTML += '    </div>';
				messageHTML += '    <div class="chatMessage-info">';
				messageHTML += '      <span class="chatMessage-time">' + moment(chatMessage.sendDt).format('A hh:mm') + '</span>';
				messageHTML += '    </div>';
				messageHTML += '  </div>';
				messageHTML += '</div>';
			  $('.chatMessage-body').append(messageHTML);				
			}
		}
		// 스크롤 맨 밑으로 내리기
 	  const chatBox = $('.chat-body'); 
 	  chatBox.scrollTop(chatBox.prop('scrollHeight'));
		
		
		
	}
 	
 	// 채팅 내역 무한 스크롤
	const fnChatMessageScrollHandler = () => {
		  var timerId;
	    
		    $('.chat-body').on('scroll', (evt) => {
		     
		      if (timerId) {  
		        clearTimeout(timerId);
		      }
		      timerId = setTimeout(() => {
		    	  
		        let scrollTop = $('.chat-body').scrollTop(); // 모달 내부의 스크롤 위치 - scrollTop
		        let modalHeight = $('.chat-body').outerHeight(); // 모달의 전체 높이 - view
		        let scrollHeight = $('.chat-body').prop('scrollHeight'); // 모달 내부의 스크롤 가능한 영역의 높이 - document
		      
		        if(scrollTop <= 400) {  
		          if (page > chatMessageTotalPage) {
		            return;
		          }
		          page++;
		          fnGetChatMessage(gChatroomNo);
		        }
	        
		        // 스크롤 원래 위치 조정
		        //const newScrollHeight = $('.chat-body').prop('scrollHeight');
		        //$('.chat-body').scrollTop(newScrollHeight - previousScrollHeight + previousScrollTop);
		      }, 100);
		    });
		};
		
		// 채팅 목록 가져오기
		const fnGetChatList = (employeeNo) => {
			
			/*
				1. DB에서 현재 로그인한 직원의 번호에 해당하는 chatroom 데이터를 List로 받아온다.
				2. 받아온 데이터를 반복문으로 돌리면서 리스트로 화면에 뿌려준다.
				
				{
				    "chatroomList": [
				        {
				            "chatroomNo": 1,
				            "creatorNo": 0,
				            "chatroomTitle": "한지수, 권태현",
				            "chatroomType": "OneToOne",
				            "chatroomCreatedDate": "2024-06-01T10:23:49.594+00:00",
				            "participantCount": 2
				        },
							...
				    ]
				}
			*/
			
			fetch('${contextPath}/chatting/getChatList.do?employeeNo=' + employeeNo, {
				method: 'GET',
			})
			.then((response) => response.json())
			.then(resData => {
				console.log(resData);
				$.each(resData.chatroomList, (i, chatroom) => {
					
					
					let msg = '';
					msg += '<li>';
					msg += '  <a href="#" style="line-height: 40px;">';
					msg += '    <img class="contacts-list-img" src="../dist/img/user1-128x128.jpg" alt="User Image">';
					msg += '    <div class="contacts-list-info" style="vertical-align: middle; color: black;">';
					msg += '      <span class="contacts-list-name" style="font-size: 15px; font-weight: 500;">' + chatroom.chatroomTitle;
					msg += '  			<input type="hidden" class="chatroom-info" data-chatroom-no=' + chatroom.chatroomNo + ' data-creator-no=' + chatroom.creatorNo + ' data-chatroom-type=' + chatroom.chatroomType + ' data-chatroom-createdDate=' + chatroom.chatroomCreatedDate + ' data-chatroom-participantCount=' + chatroom.participantCount + '>'; 
					msg += '        <small class="contacts-list-date pull-right">' + chatroom.participantCount + '</small>';
					msg += '      </span>';
					msg += '    </div>';
					msg += '  </a>';
					
					
					msg += '</li>';
				
					$('.contacts-list').append(msg);
					//fnGochatroom();
				})
			})
	 		.catch(error => {
	 			console.error('Error fetching sender data:', error);
	 		}); 
		}
		
		
		
		// 채팅방 별로 참여자 번호 가져오기
		const fnGetParticipantsNoList = (chatroomNo) => {
			return fetch('${contextPath}/chatting/getChatroomParticipantList.do?chatroomNo=' + chatroomNo, {
				method: 'GET',
			})
			.then((response) => response.json())
			.then(resData => {
				
				const chatMessageList = resData.employeeNoList;
				const senderNoList = Array.from(new Set(chatMessageList.map(message => message.participantNo)));
				
				return senderNoList;
			})
		}
		
		
		
		
		
		// 채팅방목록에서 채팅방 클릭했을 때
		const fnGochatroom = () => {
			$('.chat-member').on('click','.contacts-list-name',  (evt) => {
				
			  page = 1;
			  chatMessageTotalPage = 0;
				//$('.chatMessage-body').empty();
				$('.chat-memberProfileList').empty();
				
				// let chatroomNo = $('.chatroom-main').data('chatroom-no');
				// fetch하지 말고 input에 담긴 값으로 chatroom 객체를 만들어서 fnOpenChatroom에 보내기 
				
				// 1. input 요소 가져오기
				let $input = $(evt.target).find('input');
				console.log('$input', $input.get(0).outerHTML);
				
				// 2. 제목 가져오기
		    let title = $(evt.target).contents().filter(function() {
		      return this.nodeType === Node.TEXT_NODE;
		  	}).text().trim();
				console.log('title', title);

				// 2. chatroom 객체 생성
		    let chatroomDto = {
		        chatroomNo: $input.data('chatroom-no'),
		        creatorNo: $input.data('creator-no'),
		        chatroomTitle: title,
		        chatroomType: $input.data('chatroom-type'),
		        chatroomCreatedDate: $input.data('chatroom-createddate'),
		    };
				
		    gChatroomNo = chatroomDto.chatroomNo;
				
				// 1:1의 경우 chatroomDto.senderNo와 ${sessionScope.user.employeeNo}를 리스트로 만든다.
				fnGetParticipantsNoList(chatroomDto.chatroomNo)
				.then(senderNoList => {
					fetchSenderUserData(senderNoList);
					//fnGetChatMessage(chatroomDto.chatroomNo);
				})
				
				console.log('chatroomDto', chatroomDto);
				
				// 채팅 내역 가져오기
				//fnGetChatMessage(chatroomDto.chatroomNo);
				fnOpenChatroom(chatroomDto);
				//fnChatMessageScrollHandler();
				
				
/* 				fetch('${contextPath}/chatting/getChatroomByChatroomNo.do?chatroomNo=' + chatroomNo, {
					method: 'GET',
				})
				.then((response) => response.json())
				.then(resData => {
					
				}) */
			})
		}
  
	fnPressEnterSendBtn();		
  fnGetChatUserList();
  fnShowChatList();
  fnAddChatRoom();
  fnGochatroom();
  fnChatMessageScrollHandler();
  //fnMessageSend();
  
  </script>


<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<script src="/bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="/plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<script src="/dist/js/pages/dashboard.js"></script>  
    
<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />