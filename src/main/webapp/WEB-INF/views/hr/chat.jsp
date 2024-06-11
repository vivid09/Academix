<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="채팅" name="title"/>
 </jsp:include>


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
          <p class="chat-member-title">직원목록</p>
<!--           <div class="searchInput-cover">
            <input type="text" class="searchInput" placeholder="직원 검색">
          </div> -->
        <div class="box-body chat-member"></div> 
   			<div class="addChatroomBtn-cover">
	       <button type="button" class="btn btn-block btn-primary addChatRoomBtn">+ 새 그룹채팅방 생성</button>
	      </div>
      </div>

      
            <!-- 프로필 조회 모달창 -->
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
      
            <!-- 그룹 채팅 생성모달창 -->
      <div class="example-modal">
        <div class="modal fade" id="modal-default2" style="display: none;">
          <div class="modal-dialog">
            <div class="modal-content">
              <!-- 이 부분 프로필 조회, 채팅방 이름 변경에 따라 동적 생성 -->
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">새 채팅방 생성</h4>
              </div>
              <div class="modal-body chatModal-body">
              	<!-- 여기에 내용 넣으면 됨. -->
              	<h4 class="modal-title">선택한 멤버</h4>
              	<div class="selected-member-cover"> <!-- 여기에 선택 멤버 들어감. -->
<!-- 					        <p>이민형 대표이사</p>
					        <p>강민지 주임</p>
					        <p>권태현 책임</p>
					        <p>한다혜 사원</p>
					        <p>정우진 사원</p>
					        <p>김지현 강사</p>
					        <p>곽상태 강사</p>
					        <p>황수아 주임</p>
					        <p>김민주 책임</p>
					        <p>한다혜 사원</p>
					        <p>정우진 사원</p>
					        <p>김지현 강사</p>
					        <p>곽상태 강사</p>					 -->        
              	</div> 
              	<input class="form-control newGroupChatroom-input" type="text" maxlength='20' placeholder="채팅방 이름을 작성해주세요">
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-groupChat">확인</button>
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">취소</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      
          
         
        </div>
        
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  
  
  <script>
  

	
  const fnGetEmployeeList = () => {
	  // 새로운 태그 추가
	    //$('.chat-member').append('<p class="chat-member-title">직원 목록</p>');
	 	  $('.chat-member-title').after('<div class="searchInput-cover"></div>');
	    $('.searchInput-cover').append('<input type="text" class="searchInput" placeholder="직원 검색">')
	    $('.chat-member').append('<div id="memberArea"></div>');
	  
	  fetch('${contextPath}/hr/list.do', {
	    method: 'GET',
	  })
	    .then((response) => response.json())
	    .then((resData) => {
	      console.log(resData.employeesList);
	      console.log(resData.employeesList[0].name);
	      const departList = resData.employeesList.map((employee) => employee.depart);
	      console.log(departList);
	      var jstreeData = [];

	      // 회사 root node로 설정
	      var com = departList.find((depart) => depart.departName === '대표실');
	      if (com) { // 데이터를 배열에 추가
	        jstreeData.push({
	          id: com.departmentNo,
	          parent: '#',
	          text: com.departName,
	          icon: "fas fa-building",
	        });
	      }

	      // employee 데이터에서 대표데이터만 빼서 설정
	      var ceo = resData.employeesList.find((employee) => employee.rank.rankTitle === '대표이사');
	      console.log(ceo);
	      if (ceo) {
	        jstreeData.push({
	          id: 'emp_' + ceo.employeeNo,
	          parent: '0',
	          text: ceo.name + ' ' + ceo.rank.rankTitle,
	          icon: "fas fa-user-tie",
	        });
	      }

	      // 부서 데이터
	      departList.forEach((depart) => {
	    	console.log(depart)
	        if (depart.departName !== '대표실') {
	          jstreeData.push({
	            id: depart.departmentNo.toString(),
	            parent: depart.parentDepartNo.toString(),
	            text: depart.departName,
	            icon: "fas fa-layer-group",
	          });
	        }
	      });

	      // 직원 데이터
	      resData.employeesList.forEach((employee) => {
	    	  //console.log(employee)
	        if (employee.depart.departmentNo !== 0 && employee.employeeStatus !== 0) { // 대표이사 제외
	          if (employee.rank.rankNo === 5) {
	            jstreeData.push({
	              id: 'emp_' + employee.employeeNo,
	              parent: employee.depart.departmentNo.toString(),
	              text: employee.name + ' ' + employee.rank.rankTitle,
	              icon: "fas fa-chalkboard-teacher",
	            });
	          } else {
	            jstreeData.push({
	              id: 'emp_' + employee.employeeNo,
	              parent: employee.depart.departmentNo.toString(),
	              text: employee.name + ' ' + employee.rank.rankTitle,
	              icon: "fas fa-user",
	            });
	          }
	        }
	      });

	      // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
	      $('#memberArea').jstree({
	        'core': {
	          'data': jstreeData,
	          'themes': {
	            'icons': true,
	          },
	        },
	        'plugins': ['search', 'checkbox'],
	        'checkbox': {
	          'keep_selected_style': true,
	          'three_state': false,
	          'whole_node': false,
	          'tie_selection': false,
	          'cascade': 'down',
	        },
	      }).on('ready.jstree', function () {
	        $(this).jstree(true).open_all();
	      });

	      $('.searchInput').on('keyup', function () {
	        var searchString = $(this).val();
	        $('#memberArea').jstree('search', searchString);
	      });
	    })
	    .catch((error) => {
	      console.error('There has been a problem with your fetch operation:', error);
	    });
	  fnGetProfile();
	}

		  
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
			  

			  fetch('${contextPath}/hr/getUserProfileByNo.do?employeeNo=' + employeeNo,{
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
	  
	  
	  
	   
	   
	   
	   fnGetEmployeeList()
  
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
<!-- <script src="/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script> -->
<!-- <script src="/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script> -->
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
<!-- <script src="/dist/js/pages/dashboard.js"></script>   -->
    
<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />
