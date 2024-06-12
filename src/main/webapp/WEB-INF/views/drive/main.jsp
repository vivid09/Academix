<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
  <jsp:param value="최근 파일" name="title"/>
</jsp:include>

<style>
  h5{
    margin-top: auto;
  }
  .chat-member {
    margin-bottom: 20px;
  }
  .drag-drop-area {
    border: 2px dashed #007bff;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    margin-top: 20px;
  }
  .drag-drop-area.dragover {
      background-color: #e9ecef;
  }
  .file-list {
    margin-top: 15px;
  }
  .file-item {
    padding: 5px 0;
    border-bottom: 1px solid #ccc;
  }
</style>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>내 드라이브</h1>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-3">
          <button type="button" class="btn btn-primary btn-block margin-bottom" id="uploadButton"><i class="fa fa-upload"></i>&nbsp;&nbsp;파일 업로드</button>

          <div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">Drive</h3>

              <div class="box-tools">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <p class="chat-member-title">내 드라이브</p>
            <div class="box-body no-padding">
              <ul class="nav nav-pills nav-stacked">
                <li class="active">
                  <a href="${contextPath}/drive/main.page"><i class="fa fa-history"></i> 최근 파일</a>
                </li>
                <li>
                  <a href="${contextPath}/drive/allList.page" class="chat-member"><i class="fa fa-envelope-o"></i> 모든 파일</a>
                </li>
              </ul>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /. box -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">최근 파일</h3>

              <div class="box-tools pull-right">
                <div class="has-feedback">
                  <input type="text" class="form-control input-sm" placeholder="파일 검색">
                  <span class="glyphicon glyphicon-search form-control-feedback"></span>
                </div>
              </div>
              <!-- /.box-tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body no-padding">
              <div class="mailbox-controls">

                <div class="btn-group">
                  <button type="button" class="btn btn-default btn-sm"><i class="fa fa-trash-o"></i></button>
                  <button type="button" class="btn btn-default btn-sm"><i class="fa fa-download"></i></button>
                </div>
                <!-- /.btn-group -->
                
                <div class="pull-right">
                  1-50/200
                  <div class="btn-group">
                    <button type="button" class="btn btn-default btn-sm"><i class="fa fa-chevron-left"></i></button>
                    <button type="button" class="btn btn-default btn-sm"><i class="fa fa-chevron-right"></i></button>
                  </div>
                  <!-- /.btn-group -->
                </div>
                <!-- /.pull-right -->
                
              </div>
              <!-- /.mailbox-controls -->
              
              <div class="table-responsive mailbox-messages">
                <table class="table table-hover table-striped">
                  <tbody>
                  <tr>
                    <td>
                      <!-- Check all button -->
                      <button type="button" class="btn btn-default btn-sm checkbox-toggle"><i class="fa fa-square-o"></i></button>
                    </td>
                    <td>종류</td>
                    <td>이름</td>
                    <td>업로드 일자</td>
                    <td>파일 크기</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">5 mins ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">28 mins ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">11 hours ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">15 hours ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">Yesterday</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">2 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">2 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">2 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">2 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">2 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">4 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"></td>
                    <td class="mailbox-date">12 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">12 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">14 days ago</td>
                  </tr>
                  <tr>
                    <td><input type="checkbox"></td>
                    <td class="mailbox-name"><a href="read-mail.html">Alexander Pierce</a></td>
                    <td class="mailbox-subject"><b>AdminLTE 2.0 Issue</b> - Trying to find a solution to this problem...
                    </td>
                    <td class="mailbox-attachment"><i class="fa fa-paperclip"></i></td>
                    <td class="mailbox-date">15 days ago</td>
                  </tr>
                  </tbody>
                </table>
                <!-- /.table -->
              </div>
              <!-- /.mail-box-messages -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer no-padding">
              <div>${paging}</div>
            </div>
          </div>
          <!-- /. box -->
        </div>
        <!-- /.col -->
        <!-- 파일 업로드 모달창 -->
        <div class="example-modal">
          <div class="modal fade" id="uploadModal" style="display: none;">
            <div class="modal-dialog">
              <div class="modal-content">
                <!-- 이 부분 프로필 조회, 채팅방 이름 변경에 따라 동적 생성 -->
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                  <h4 class="modal-title">파일 업로드</h4>
                </div>
                <div class="modal-body">
                  <!-- 여기에 내용 넣으면 됨. -->
                  <form id="frm-upload-register"
                        method="POST"
                        enctype="multipart/form-data"
                        action="${contextPath}/drive/register.do">
                    <!-- 폴더 구조 가져와서 어디에 파일 저장할지 선택하도록 하기
                          -> 선택한 폴더 번호 같이 서버로 갈 수 있도록 저장하기 -->
                    <h5>파일을 저장할 경로를 선택해주세요.</h5>
                    <div class="folder-list"></div>
                    <input type="hidden" id="folderUploadPath" name="folderUploadPath">
                    <div class="drag-drop-area" id="dragDropArea">
                      <p>파일을 여기에 드래그 앤 드롭 하거나 클릭하여 선택하세요</p>
                    </div>
                    <input type="file" id="files" multiple style="display:none">
                    <div class="file-list" id="fileList"></div>
                  </form>
                </div>
                <div class="modal-footer">
                  <input type="hidden" name="ownerNo" value="${sessionScope.user.employeeNo}">
                  <button type="submit" class="btn btn-primary pull-left">업로드</button>
                  <button type="button" class="btn btn-secondary pull-left" data-dismiss="modal">닫기</button>
                </div>
              </div>
              <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
          </div>
          <!-- /.modal -->
        </div>
        <!-- /.example-modal -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


<!-- jQuery 2.2.3 -->
<script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="../../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/app.min.js"></script>
<!-- iCheck -->
<script src="../../plugins/iCheck/icheck.min.js"></script>
<!-- jsTree 3.3.12 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

<!-- Page Script -->
<script>
  $(function () {
    //Enable iCheck plugin for checkboxes
    //iCheck for checkbox and radio inputs
    $('.mailbox-messages input[type="checkbox"]').iCheck({
      checkboxClass: 'icheckbox_flat-blue',
      radioClass: 'iradio_flat-blue'
    });

    //Enable check and uncheck all functionality
    $(".checkbox-toggle").click(function () {
      var clicks = $(this).data('clicks');
      if (clicks) {
        //Uncheck all checkboxes
        $(".mailbox-messages input[type='checkbox']").iCheck("uncheck");
        $(".fa", this).removeClass("fa-check-square-o").addClass('fa-square-o');
      } else {
        //Check all checkboxes
        $(".mailbox-messages input[type='checkbox']").iCheck("check");
        $(".fa", this).removeClass("fa-square-o").addClass('fa-check-square-o');
      }
      $(this).data("clicks", !clicks);
    });
  });
  
  // 파일 업로드하는 버튼
  document.getElementById('uploadButton').addEventListener('click', () => {
    $('#uploadModal').modal('show');
    
    // Drag and Drop
    var dragDropArea = document.getElementById('dragDropArea');
    var fileInput = document.getElementById('files');

    dragDropArea.addEventListener('dragover', (evt) => {
      evt.preventDefault();
      evt.stopPropagation();
      dragDropArea.classList.add('dragover');
    });

    dragDropArea.addEventListener('dragleave', (evt) => {
      evt.preventDefault();
      evt.stopPropagation();
      dragDropArea.classList.remove('dragover');
    });

    dragDropArea.addEventListener('drop', (evt) => {
      evt.preventDefault();
      evt.stopPropagation();
      dragDropArea.classList.remove('dragover');
      var files = evt.dataTransfer.files;
      handleFiles(files);
    });

    dragDropArea.addEventListener('click', () => {
      fileInput.click();
    });

    fileInput.addEventListener('change', (evt) => {
      var files = evt.target.files;
      handleFiles(files);
    });

    function handleFiles(files) {
      fileList.innerHTML = ''; // 기존 파일 목록 초기화
      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var fileItem = document.createElement('div');
        fileItem.className = 'file-item';
        fileItem.textContent = file.name;
        fileList.appendChild(fileItem);
      }
    }
  });
  
  // -------------------------------------------- 폴더 구조 --------------------------------------------
  // 드라이브 리스트 가져오기
  const fnGetFileList = () => {
    // 새로운 태그 추가
    $('.chat-member-title').after('<div class="searchInput-cover"></div>');
    $('.searchInput-cover').append('<input type="text" class="searchInput" placeholder="파일 검색">')
    $('.chat-member').append('<div class="memberArea"></div>');
    
    fetch('${contextPath}/drive/getFileList.do',{
      method: 'GET',
    })
    .then((response) => response.json())
    .then(resData => {
    
      // 변환한 데이터 담을 배열 선언
      var jstreeData = [];
      
      // 회사 root node로 설정
      var drive = resData.folder.find(folder => folder.folderName === 'drive');
      if(drive) {
        jstreeData.push({
          id: drive.folderNo,
          parent: '#',
          text: drive.folderName,
          icon: "fas fa-building"
        });
      }
      
      /*
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
      */
      
      // 폴더 데이터
      resData.folder.forEach(function(folder) {
        if(folder.folderName !== 'drive'){
          jstreeData.push({
            id: folder.folderNo.toString(),
            parent: folder.parentFolderNo.toString(),
            text: folder.folderName,
            icon: "fas fa-layer-group"
          });
        }
      });
      
      /*
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
      */
      
      // 파일 데이터
      resData.file.forEach(function(file) {
        jstreeData.push({
          id: 'file_' + file.fileNo,
          parent: file.folder.folderNo.toString(),
          text: file.originalFilename,
          icon: "fas fa-user"
        });
      });
      
      console.log('jstreeData', jstreeData);
      
      // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
      $('.memberArea').jstree({
        'core': {
          'data': jstreeData,
            'themes': {
               'icons': true
            }
        },
        'plugins': ['search'],           
      }).on('ready.jstree', function() {
        $(this).jstree(true).open_all();
      })
      
      // 검색 기능 추가
      $('.searchInput').on('keyup', function() {
        var searchString = $(this).val();
        $('.memberArea').jstree('search', searchString);
      });
      
    })
    .catch(error => {
      console.error('There has been a problem with your fetch operation:', error);
    });
  }
    
  // -------------------------------------------- 모달 폴더 구조 --------------------------------------------
  /*
    체크박스 사용, 폴더경로 받아오도록,
    
    폴더 검색 가능하도록 위치 설정
  */
  
  // 저장위치 설정할 폴더 리스트 가져오기
  const fnGetFileListForSave = () => {
    // $('.chat-member-title').after('<div class="searchInput-cover"></div>');
    // $('.searchInput-cover').append('<input type="text" class="searchInput" placeholder="파일 검색">');
    $('.folder-list').append('<div class="folderArea"></div>');
    
    fetch('${contextPath}/drive/getFileList.do',{
      method: 'GET',
    })
    .then((response) => response.json())
    .then(resData => {
    
      // 변환한 데이터 담을 배열 선언
      var jstreeData = [];
      
      // drive root node로 설정
      var drive = resData.folder.find(folder => folder.folderName === 'drive');
      if(drive) {
        jstreeData.push({
          id: drive.folderNo,
          parent: '#',
          text: drive.folderName,
          icon: "fas fa-building"
        });
      }
      
      // 폴더 데이터
      resData.folder.forEach(function(folder) {
        if(folder.folderName !== 'drive'){
          jstreeData.push({
            id: folder.folderNo.toString(),
            parent: folder.parentFolderNo.toString(),
            text: folder.folderName,
            icon: "fas fa-layer-group"
          });
        }
      });
      
      // 파일 데이터
      resData.file.forEach(function(file) {
        jstreeData.push({
          id: 'file_' + file.fileNo,
          parent: file.folder.folderNo.toString(),
          text: file.originalFilename,
          icon: "fas fa-user"
        });
      });
      
      console.log('jstreeData', jstreeData);
      
      // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
      $('.folderArea').jstree({
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
      }).on('changed.jstree', function (e, data) {
        var selectedNode = data.instance.get_node(data.selected[0]);
        if (selectedNode) {
          var selectedFolderNo = selectedNode.id;
          var selectedFolder = resData.folder.find(folder => folder.folderNo.toString() === selectedFolderNo);
          if (selectedFolder) {
            document.getElementById('folderUploadPath').value = selectedFolder.folderUploadPath;
          }
        }
      });
      
      /*
      // 검색 기능 추가
      $('.searchInput').on('keyup', function() {
        var searchString = $(this).val();
        $('.folderArea').jstree('search', searchString);
      });
      */
    })
    .catch(error => {
      console.error('There has been a problem with your fetch operation:', error);
    });
    
  }
  
  
  fnGetFileList();
  fnGetFileListForSave();
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />