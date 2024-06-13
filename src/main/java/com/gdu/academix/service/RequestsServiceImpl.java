package com.gdu.academix.service;

import java.io.File;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.AttendanceAdjustmentRequestDto;
import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RanksDto;
import com.gdu.academix.dto.RequestAttachDto;
import com.gdu.academix.dto.RequestsDto;
import com.gdu.academix.mapper.RequestsMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class RequestsServiceImpl implements RequestsService {

  @Autowired
  private RequestsMapper requestsMapper;
  @Autowired
  private MyPageUtils myPageUtils;
  @Autowired
  private MyFileUtils myfileUtils;
  
  @Override
  @Transactional
  public boolean createLeaveRequest(MultipartHttpServletRequest multipartRequest) {
    
	  String departName = multipartRequest.getParameter("departName");
	    String name = multipartRequest.getParameter("name");
	    String rankTitle = multipartRequest.getParameter("rankTitle");
	    String reason = multipartRequest.getParameter("reason");
	    int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
	    int requestSort = Integer.parseInt(multipartRequest.getParameter("requestSort"));
	    int picNo = Integer.parseInt(multipartRequest.getParameter("picNo"));
	    int requestStatus = Integer.parseInt(multipartRequest.getParameter("requestStatus"));
	    
	    DepartmentsDto depart = new DepartmentsDto();
	    depart.setDepartName(departName);
	    RanksDto rank = new RanksDto();
	    rank.setRankTitle(rankTitle);
	    
	    EmployeesDto employees = EmployeesDto.builder()
	                                         .depart(depart)
	                                         .name(name)
	                                         .employeeNo(employeeNo)
	                                         .rank(rank)
	                                         
	                                         .build();
	    RequestsDto requests = RequestsDto.builder()
	                                      .employees(employees)
	                                      .requestSort(requestSort)
	                                      .reason(reason)
	                                      .picNo(picNo)
	                                      .requestStatus(requestStatus)
	                                      .build();
	    
	    
	    Double duration = Double.parseDouble(multipartRequest.getParameter("duration"));
	    String startDateString = multipartRequest.getParameter("startDate");
	    String endDateString = multipartRequest.getParameter("endDate");
	    int leaveType = Integer.parseInt(multipartRequest.getParameter("leaveType"));

	    LocalDate startDate = LocalDate.parse(startDateString);
	    LocalDate endDate = LocalDate.parse(endDateString);

	    // LocalDate를 SQL Date로 변환
	    Date sqlStartDate = Date.valueOf(startDate);
	    Date sqlEndDate = Date.valueOf(endDate);

	    LeaveRequestDto leaveRequest = LeaveRequestDto.builder()
	                                                  .requests(requests)
	                                                  .startDate(sqlStartDate)
	                                                  .endDate(sqlEndDate)
	                                                  .duration(duration)
	                                                  .leaveType(leaveType)
	                                                  .build();
	    
	    int insertCount = requestsMapper.insertRequest(requests);
	    int requestNo = requests.getRequestNo(); // 요청에서 requestNo 가져오기
	    leaveRequest.getRequests().setRequestNo(requestNo); // LeaveRequestDto에 설정
	     insertCount += requestsMapper.insertLeaveRequest(leaveRequest);
	    
	     List<MultipartFile> files = multipartRequest.getFiles("files");
		    
		    // 첨부 파일이 없는 경우 : [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]]
		    // 첨부 파일이 있는 경우 : [MultipartFile[field="files", filename=404.jpg, contentType=image/jpeg, size=63891]]
		    // System.out.println(files);

	     int insertAttachCount=0;
		    try {
		    	 if(files.get(0).getSize() == 0) {
		 	    	insertAttachCount = 1;  // 첨부가 없어도 files.size() 는 1 이다.
		 	    } else {
		 	    	insertAttachCount = 0;
		 	    }
		 	    
		 	    for (MultipartFile multipartFile : files) {
		 	      
		 	      if(multipartFile != null && !multipartFile.isEmpty()) {
		 	        
		 	        String uploadPath = myfileUtils.getUploadPath();
		 	        File dir = new File(uploadPath);
		 	        if(!dir.exists()) {
		 	          dir.mkdirs();
		 	        }
		 	        
		 	        String originalFilename = multipartFile.getOriginalFilename();
		 	        String filesystemName = myfileUtils.getFilesystemName(originalFilename);
		 	        File file = new File(dir, filesystemName);
		 	        System.out.println(dir);
		 	        System.out.println(filesystemName);
		 	        multipartFile.transferTo(file);
		 	        
		 	        RequestAttachDto attach = RequestAttachDto.builder()
		 	        		                                  .requestNo(requestNo)
		 	        		                                  .uploadPath(uploadPath)
		 	        		                                  .filesystemName(filesystemName)
		 	        		                                  .originalFileName(originalFilename)
		 	        		                                  .build();
		 	       insertAttachCount += requestsMapper.insertRequestsAttach(attach);
		 	
		     }
		 	      
		   } 
				
			} catch (Exception e) {
				e.printStackTrace();
			}

	     
	    
	    return (insertCount == 1) && (insertAttachCount == files.size());
  }
  
  @Transactional
  @Override
  public boolean createAttendanceRequest(MultipartHttpServletRequest multipartRequest) {
	    int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
	    int requestStatus = Integer.parseInt(multipartRequest.getParameter("requestStatus"));
	    String reason = multipartRequest.getParameter("reason");
	    int requestSort = Integer.parseInt(multipartRequest.getParameter("requestSort"));
	    int picNo = Integer.parseInt(multipartRequest.getParameter("picNo"));
	    
		
		  String adjustmentDateString = multipartRequest.getParameter("adjustmentDate"); 
		  //LocalDate adjustmentDate =  LocalDate.parse(adjustmentDateString);
		  // LocalDate를 SQL Date로 변환 Date sqlStartDate = Date.valueOf(adjustmentDate);
		 

	    int insertAttendanceCount = 0;
	    int insertAttachCount = 0;
	    List<MultipartFile> files = null;

	    try {
	        String timeInString = multipartRequest.getParameter("timeIn");
	        String timeOutString = multipartRequest.getParameter("timeOut");
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
	        java.util.Date parsedDate = timeFormat.parse(timeInString);
	        java.util.Date parsedDate2 = timeFormat.parse(timeOutString);
	        java.util.Date parsedDate3 = dateFormat.parse(adjustmentDateString);
	        Timestamp timeIn = new Timestamp(parsedDate.getTime());
	        Timestamp timeOut = new Timestamp(parsedDate2.getTime());
	        Timestamp adjustmentDate = new Timestamp(parsedDate3.getTime());

	        EmployeesDto employees = EmployeesDto.builder()
	                                             .employeeNo(employeeNo)
	                                             .build();

	        RequestsDto requests = RequestsDto.builder()
	                                          .requestStatus(requestStatus)
	                                          .employees(employees)
	                                          .reason(reason)
	                                          .picNo(picNo)
	                                          .requestSort(requestSort)
	                                          .build();

	        AttendanceAdjustmentRequestDto attendanceAdjustment = AttendanceAdjustmentRequestDto.builder()
	                                                                                           .timeIn(timeIn)
	                                                                                           .timeOut(timeOut)
	                                                                                           .requests(requests)
	                                                                                           .adjustmentDate(adjustmentDate)
	                                                                                           .build();

	        insertAttendanceCount = requestsMapper.insertRequest(requests);
	        insertAttendanceCount += requestsMapper.insertAttendanceRequests(attendanceAdjustment);

	        files = multipartRequest.getFiles("files");

	        if (files != null && !files.isEmpty()) {
	            if (files.get(0).getSize() == 0) {
	                insertAttachCount = 1;  // 첨부가 없어도 files.size() 는 1 이다.
	            } else {
	                insertAttachCount = 0;
	            }

	            for (MultipartFile multipartFile : files) {
	                if (multipartFile != null && !multipartFile.isEmpty()) {
	                    String uploadPath = myfileUtils.getUploadPath();
	                    File dir = new File(uploadPath);
	                    if (!dir.exists()) {
	                        dir.mkdirs();
	                    }

	                    String originalFilename = multipartFile.getOriginalFilename();
	                    String filesystemName = myfileUtils.getFilesystemName(originalFilename);
	                    File file = new File(dir, filesystemName);
	                    multipartFile.transferTo(file);

	                    int requestNo = requests.getRequestNo();
	                    RequestAttachDto attach = RequestAttachDto.builder()
	                                                              .requestNo(requestNo)
	                                                              .uploadPath(uploadPath)
	                                                              .filesystemName(filesystemName)
	                                                              .originalFileName(originalFilename)
	                                                              .build();
	                    insertAttachCount += requestsMapper.insertRequestsAttach(attach);
	                }
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return (insertAttendanceCount == 2) && (insertAttachCount == files.size());
	}

  
 
  @Override
  public void prepareRequestsList(HttpServletRequest request, Model model) {
	    int total = requestsMapper.getRequestsCount();
	    
	    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
	    int display = Integer.parseInt(optDisplay.orElse("10"));
	    
	    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
	    int page = Integer.parseInt(optPage.orElse("1"));

	    myPageUtils.setPaging(total, display, page);
	    
	    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
	    String sort = optSort.orElse("DESC");
	    
	    Optional<String> optStatus = Optional.ofNullable(request.getParameter("status"));
	    String status = optStatus.orElse("all");
	    
	    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
	                                   , "end", myPageUtils.getEnd()
	                                   , "sort", sort
	                                   , "status", status);    
	    
	    model.addAttribute("beginNo", total - (page - 1) * display);
	    model.addAttribute("requestsList", requestsMapper.getList(map));
	    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/requests/maing.page", sort, display));
	    model.addAttribute("display", display);
	    model.addAttribute("sort", sort);
	    model.addAttribute("page", page);
	    model.addAttribute("status", status);
	}
  
  
  @Override
	public LeaveRequestDto getRequestsbyNo(int requestNo) {
		
		return requestsMapper.getRequestsbyNo(requestNo);
	}
  
  @Override
	public AttendanceAdjustmentRequestDto getAttendanceRequestNo(int requestNo) {
		return requestsMapper.getAttendanceRequestNo(requestNo);
	}

  
  @Override
	public int requestApproval(HttpServletRequest request) {
    System.out.println(request.getParameter("requestStatus"));
	  int requestStatus = Integer.parseInt(request.getParameter("requestStatus"));
	  int picNo = Integer.parseInt(request.getParameter("picNo")); 
	  int requestNo = Integer.parseInt(request.getParameter("requestNo")); 
	  RequestsDto requests = RequestsDto.builder()
			  						    .requestStatus(requestStatus)
			  						    .picNo(picNo)
			  						    .requestNo(requestNo)
			  						    .build();
	  int moddifyCount = requestsMapper.requestApproval(requests);
	  
		return moddifyCount;
	}
  
  @Override
	public int requestReject(HttpServletRequest request) {
	  int requestStatus = Integer.parseInt(request.getParameter("requestStatus"));
	  int picNo = Integer.parseInt(request.getParameter("picNo")); 
	  int requestNo = Integer.parseInt(request.getParameter("requestNo"));
	  String rejectReason = request.getParameter("rejectReason");
	  RequestsDto requests = RequestsDto.builder()
			  						    .requestStatus(requestStatus)
			  						    .picNo(picNo)
			  						    .requestNo(requestNo)
			  						    .rejectReason(rejectReason)
			  						    .build();
	  int rejectCount = requestsMapper.requestReject(requests);
	  
		return rejectCount;
	}

  @Override
	public void getRequestsList(HttpServletRequest request, Model model) {
		
	
	    
	    int total = requestsMapper.getRequestsCount();
	    
	    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
	    int display = Integer.parseInt(optDisplay.orElse("10"));
	    
	    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
	    int page = Integer.parseInt(optPage.orElse("1"));

	    myPageUtils.setPaging(total, display, page);
	    
	    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
	    String sort = optSort.orElse("DESC");
	    
	    Optional<String> optStatus = Optional.ofNullable(request.getParameter("status"));
	    String status = optStatus.orElse("all");
	    
	    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
	                                   , "end", myPageUtils.getEnd()
	                                   , "sort", sort
	                                   , "status", status);	    
	    
	    model.addAttribute("beginNo", total - (page - 1) * display);
	    model.addAttribute("requestsList", requestsMapper.getList(map));
	    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/requests/requestsList.do", sort, display));
	    model.addAttribute("display", display);
	    model.addAttribute("sort", sort);
	    model.addAttribute("page", page);
	    model.addAttribute("status", status);
	    
	}
  
  @Override
	public int modifyRequest(MultipartHttpServletRequest multipartRequest) {
		
	  String departName = multipartRequest.getParameter("departName");
	  String name = multipartRequest.getParameter("name");
	  String rankTitle = multipartRequest.getParameter("rankTitle");
	  String reason = multipartRequest.getParameter("reason");
	  int leaveType = Integer.parseInt(multipartRequest.getParameter("leaveType"));
	  Double duration = Double.parseDouble(multipartRequest.getParameter("duration"));
	   String startDateString = multipartRequest.getParameter("startDate");
	   String endDateString = multipartRequest.getParameter("endDate");
	   int requestNo = Integer.parseInt(multipartRequest.getParameter("requestNo"));
	   
	   LocalDate startDate = LocalDate.parse(startDateString);
	    LocalDate endDate = LocalDate.parse(endDateString);

	    // LocalDate를 SQL Date로 변환
	    Date sqlStartDate = Date.valueOf(startDate);
	    Date sqlEndDate = Date.valueOf(endDate);
	    
	    DepartmentsDto depart = new DepartmentsDto();
	    depart.setDepartName(departName);
	    RanksDto rank = new RanksDto();
	    rank.setRankTitle(rankTitle);
	    
	    EmployeesDto employees = EmployeesDto.builder()
	                                         .depart(depart)
	                                         .name(name)
	                                         .rank(rank)
	                                         
	                                         .build();
	    RequestsDto requests = RequestsDto.builder()
	    		                          .requestNo(requestNo)
	                                      .employees(employees)
	                                      .reason(reason)
	                                      .build();
	    
	    LeaveRequestDto leaveRequest = LeaveRequestDto.builder()
                .requests(requests)
                .startDate(sqlStartDate)
                .endDate(sqlEndDate)
                .duration(duration)
                .leaveType(leaveType)
                .build();
	    
	    int modifyCount = requestsMapper.requestModify2(requests);
	     modifyCount += requestsMapper.requestModify(leaveRequest);
      
	     List<MultipartFile> files = multipartRequest.getFiles("files");
		    
		    // 첨부 파일이 없는 경우 : [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]]
		    // 첨부 파일이 있는 경우 : [MultipartFile[field="files", filename=404.jpg, contentType=image/jpeg, size=63891]]
		    // System.out.println(files);

		    try {
		    	 if(files.get(0).getSize() == 0) {
		    		 modifyCount = 1;  // 첨부가 없어도 files.size() 는 1 이다.
		 	    } else {
		 	    	modifyCount = 0;
		 	    }
		 	    
		 	    for (MultipartFile multipartFile : files) {
		 	      
		 	      if(multipartFile != null && !multipartFile.isEmpty()) {
		 	        
		 	        String uploadPath = myfileUtils.getUploadPath();
		 	        File dir = new File(uploadPath);
		 	        if(!dir.exists()) {
		 	          dir.mkdirs();
		 	        }
		 	        
		 	        String originalFilename = multipartFile.getOriginalFilename();
		 	        String filesystemName = myfileUtils.getFilesystemName(originalFilename);
		 	        File file = new File(dir, filesystemName);
		 	        
		 	        RequestAttachDto attach = RequestAttachDto.builder()
		 	        		                                  .requestNo(requestNo)
		 	        		                                  .uploadPath(uploadPath)
		 	        		                                  .filesystemName(filesystemName)
		 	        		                                  .originalFileName(originalFilename)
		 	        		                                  .build();
		 	       modifyCount += requestsMapper.requestModify3(attach);
		 	
		     }
		 	      
		   } 
				
			} catch (Exception e) {
				e.printStackTrace();
			}

	    
		return modifyCount;
	}
  
  @Transactional
  @Override
	public int attendanceModify(MultipartHttpServletRequest multipartRequest) {
		
	    String reason = multipartRequest.getParameter("reason");
	    int requestNo = Integer.parseInt(multipartRequest.getParameter("requestNo"));
		
		  String adjustmentDateString = multipartRequest.getParameter("adjustmentDate"); 
		  //LocalDate adjustmentDate =  LocalDate.parse(adjustmentDateString);
		  // LocalDate를 SQL Date로 변환 Date sqlStartDate = Date.valueOf(adjustmentDate);
		 

	    int modifyCount = 0;
	    List<MultipartFile> files = null;

	    try {
	        String timeInString = multipartRequest.getParameter("timeIn");
	        String timeOutString = multipartRequest.getParameter("timeOut");
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
	        java.util.Date parsedDate = timeFormat.parse(timeInString);
	        java.util.Date parsedDate2 = timeFormat.parse(timeOutString);
	        java.util.Date parsedDate3 = dateFormat.parse(adjustmentDateString);
	        Timestamp timeIn = new Timestamp(parsedDate.getTime());
	        Timestamp timeOut = new Timestamp(parsedDate2.getTime());
	        Timestamp adjustmentDate = new Timestamp(parsedDate3.getTime());

	        EmployeesDto employees = EmployeesDto.builder()
	                                             .build();

	        RequestsDto requests = RequestsDto.builder()
	        		                          .requestNo(requestNo)
	                                          .employees(employees)
	                                          .reason(reason)
	                                          .build();

	        AttendanceAdjustmentRequestDto attendanceAdjustment = AttendanceAdjustmentRequestDto.builder()
	                                                                                           .timeIn(timeIn)
	                                                                                           .timeOut(timeOut)
	                                                                                           .requests(requests)
	                                                                                           .adjustmentDate(adjustmentDate)
	                                                                                           .build();

	        modifyCount = requestsMapper.attendanceModify(attendanceAdjustment);
	        modifyCount += requestsMapper.attendanceModify2(requests);

	        files = multipartRequest.getFiles("files");

	        if (files != null && !files.isEmpty()) {
	            if (files.get(0).getSize() == 0) {
	            	modifyCount = 1;  // 첨부가 없어도 files.size() 는 1 이다.
	            } else {
	            	modifyCount = 0;
	            }

	            for (MultipartFile multipartFile : files) {
	                if (multipartFile != null && !multipartFile.isEmpty()) {
	                    String uploadPath = myfileUtils.getUploadPath();
	                    File dir = new File(uploadPath);
	                    if (!dir.exists()) {
	                        dir.mkdirs();
	                    }

	                    String originalFilename = multipartFile.getOriginalFilename();
	                    String filesystemName = myfileUtils.getFilesystemName(originalFilename);
	                    File file = new File(dir, filesystemName);
	                    multipartFile.transferTo(file);

	                     int requestNo2 = requests.getRequestNo();
	                    RequestAttachDto attach = RequestAttachDto.builder()
	                                                              .requestNo(requestNo2)
	                                                              .uploadPath(uploadPath)
	                                                              .filesystemName(filesystemName)
	                                                              .originalFileName(originalFilename)
	                                                              .build();
	                    modifyCount += requestsMapper.attendanceModify3(attach);
	                }
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return modifyCount;
	}
  
  @Override
	public int removeRequest(int requestNo) {
	  int deleteCount = requestsMapper.removeRequest2(requestNo);
	  deleteCount += requestsMapper.removeRequest3(requestNo);
	   deleteCount += requestsMapper.removeRequest(requestNo);
		return deleteCount;
	}
  
  @Override
	public ResponseEntity<Map<String, Object>> pending() {
	  
      
	  return ResponseEntity.ok(Map.of("0", requestsMapper.pending(0)
			                          ,"1",requestsMapper.pending(1)
			                          , "2",requestsMapper.pending(2)));
	}
  
  @Override
	public ResponseEntity<Resource> download(HttpServletRequest request) {
	// 첨부 파일 정보를 DB 에서 가져오기
	    int attachNo = Integer.parseInt(request.getParameter("attachNo"));
	    RequestAttachDto attach = requestsMapper.getAttachByNo(attachNo);
	    
	    // 첨부 파일 정보를 File 객체로 만든 뒤 Resource 객체로 변환
	    File file = new File(attach.getUploadPath(), attach.getFilesystemName());
	    Resource resource = new FileSystemResource(file);
	    
	    // 첨부 파일이 없으면 다운로드 취소
	    if(!resource.exists()) {
	      return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	    
	    // DOWNLOAD_COUNT 증가
	    requestsMapper.updateDownloadCount(attachNo);
	    
	    // 사용자가 다운로드 받을 파일명 결정 (originalFilename 을 브라우저에 따라 다르게 인코딩 처리)
	    String originalFilename = attach.getOriginalFileName();
	    String userAgent = request.getHeader("User-Agent");
	    try {
	      // IE
	      if(userAgent.contains("Trident")) {
	       originalFilename = URLEncoder.encode(originalFilename, "UTF-8").replace("+", " "); 
	      }
	      // Edge
	      else if(userAgent.contains("Edg")) {
	        originalFilename = URLEncoder.encode(originalFilename, "UTF-8");
	      }
	      // Other
	      else {
	        originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    
	    // 다운로드용 응답 헤더 설정 (HTTP 참조)
	    HttpHeaders responseHeader = new org.springframework.http.HttpHeaders();
	    responseHeader.add("Content-Type", "application/octet-stream");
	    responseHeader.add("Content-Disposition", "attachment; filename=" + originalFilename);
	    responseHeader.add("Content-Length", file.length() + "");
	    
	    // 다운로드 진행
	    return new ResponseEntity<Resource>(resource, responseHeader, HttpStatus.OK);
	}
  
}
