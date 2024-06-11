package com.gdu.academix.service;

import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.CourseDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.mapper.CourseMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class CoursesServiceImpl implements CoursesService {
  @Value("${service.file.uploadurl}")
  public String UP_DIR;
  
  private final CourseMapper courseMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  public CoursesServiceImpl(CourseMapper courseMapper, MyPageUtils myPageUtils, MyFileUtils myFileUtils) {
  	super();
  	this.courseMapper = courseMapper;
  	this.myPageUtils = myPageUtils;
  	this.myFileUtils = myFileUtils;
  }

  @Override
  public boolean registerCourse(MultipartHttpServletRequest multipartRequest) throws Exception {

  	SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
  	
    String title = multipartRequest.getParameter("title");
    String description = multipartRequest.getParameter("description");
    Date startDate = dateTimeFormat.parse((String) multipartRequest.getParameter("startDate"));
    Date endDate = dateTimeFormat.parse((String) multipartRequest.getParameter("endDate"));
    String coursePlan = "";
    int empNo = Integer.parseInt(multipartRequest.getParameter("empNo"));
    int status;
    
    // 첨부 파일 처리하기
    List<MultipartFile> files = multipartRequest.getFiles("coursePlan");
    
    // 첨부 파일이 없는 경우 : [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]]
    // 첨부 파일이 있는 경우 : [MultipartFile[field="files", filename=404.jpg, contentType=image/jpeg, size=63891]]
    
    for (MultipartFile multipartFile : files) {
      if(multipartFile != null && !multipartFile.isEmpty()) {
        StringBuilder sb = new StringBuilder();
        String uploadPath = myFileUtils.getCoursePlanPath();
        File dir = new File(uploadPath);
        System.out.println("====="+dir.getAbsolutePath());
        if(!dir.exists()) {
          dir.mkdirs();
        }
        
        String originalFilename = multipartFile.getOriginalFilename();
        String filesystemName = myFileUtils.getFilesystemName(originalFilename);
        File file = new File(dir, filesystemName);
        String relativePath = uploadPath.substring(UP_DIR.length());
        sb.append(multipartRequest.getContextPath()).append(relativePath).append("/") .append(filesystemName);
        
        try {
          multipartFile.transferTo(file);  // 파일을 지정된 경로에 저장
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }
        coursePlan = sb.toString();
      }  // if
    }  // for
    
    
    EmployeesDto emp = new EmployeesDto();
    emp.setEmployeeNo(empNo);
    
    CourseDto course = CourseDto.builder()
                          .title(title)
                          .description(description)
                          .startDate(new Timestamp(startDate.getTime()))
                          .endDate(new Timestamp(endDate.getTime()))
                          .coursePlan(coursePlan)
                          .employee(emp)
                        .build();
    
    if(multipartRequest.getParameter("status") != null) {
    	status = Integer.parseInt(multipartRequest.getParameter("status"));
    	course.setCourseState(status);
    }
    
    int insertCourseCount = courseMapper.insertCourse(course);
    
    return insertCourseCount == 1;
  }

  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> loadCourseList(HttpServletRequest request) {
    
    // 전체 블로그 개수
    int total = courseMapper.getCourseCount();
    
    // 스크롤 이벤트마다 가져갈 목록 개수
    int display = 10;
    
    // 표시할 페이지 번호
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    
    // 페이징 처리에 필요한 정보 처리
    myPageUtils.setPaging(total, display, page);
    
    // DB 로 보낼 Map 생성
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    
    // 목록 화면으로 반환할 값 (목록 + 전체 페이지 수)
    return new ResponseEntity<>(Map .of("courseList", courseMapper.getCourseList(map)
                                      , "totalPage", myPageUtils.getTotalPage()
                                      , "paging", myPageUtils.getPaging(request.getContextPath() + "/courses/list.do"
                                      , null
                                      , display))
                              , HttpStatus.OK);

  }
  
  @Transactional(readOnly=true)
  @Override
  public CourseDto getCourseByNo(int courseNo) {
    return courseMapper.getCourseByNo(courseNo);
  }
  
  @Override
  public int modifyCourse(CourseDto course) {
    return courseMapper.updateCourse(course);
  }
  
  @Override
  public int removeCourse(int courseNo) {
    return courseMapper.deleteCourse(courseNo);
    
  }
  
}
