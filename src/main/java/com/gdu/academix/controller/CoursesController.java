package com.gdu.academix.controller;

import java.text.ParseException;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.CoursesService;

import jakarta.servlet.http.HttpServletRequest;

@RequestMapping("/courses")
@Controller
public class CoursesController {

		
  private final CoursesService coursesService;
	
  public CoursesController(CoursesService coursesService) { 
  	super();
  	this.coursesService = coursesService; 
  }
		
  @GetMapping("/createCourseRequest.page")
  public String createCourseRequestPage() {
    return "courses/createCourseRequest";
  }
  
  @GetMapping("/manageCourses.page")
  public String manageCoursesPage() {
  	return "courses/manageCourses";
  }
  

  @PostMapping(value="/createCourseRequest.do", produces="application/json")
  public String registerAttendanceRecord(MultipartHttpServletRequest multipartRequest
      																 , RedirectAttributes redirectAttributes) throws Exception {
    boolean insertCount = coursesService.registerCourse(multipartRequest);
    return "redirect:/courses/manageCourses.page";
  }
  
  @GetMapping("/manageCourses/list.do")
  public ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request) {
    return coursesService.loadCourseList(request);
  }
  
  @GetMapping("/manageCourses/detail.do")
  public String detail(@RequestParam int courseNo, Model model) {
    model.addAttribute("course", coursesService.getCourseByNo(courseNo));
    return "courses/detail";
  }

  @PostMapping(value="/removeEvent.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> removeEvent(@RequestBody int courseNo) {
    int removeCount = coursesService.removeCourse(courseNo);
    return ResponseEntity.ok(Map.of("removeCount", removeCount == 1 ? "강의가 삭제되었습니다." : "강의가 삭제되지 않았습니다."));
  }
  
  
//  @PostMapping(value="commute/updateAttendanceRecord.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> updateAttendanceRecord(@RequestBody Map<String, Object> params) throws ParseException {
//    int insertCount = attendanceService.updateAttendanceRecord(params);
//    return ResponseEntity.ok(Map.of("insertResult", insertCount == 1 ? "정상 처리되었습니다." : "정상 처리되지 않았습니다."));
//  }
//  
//  @PostMapping(value="/removeEvent.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> removeEvent(@RequestBody int eventNo, RedirectAttributes redirectAttributes) {
//    int removeCount = calendearService.removeEvent(eventNo);
//    return ResponseEntity.ok(Map.of("removeCount", removeCount == 1 ? "일정이 삭제되었습니다." : "일정이 삭제되지 않았습니다."));
//  }
  
//  @GetMapping(value="commute/getAttendanceRecords.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> getAttendanceRecords(@RequestParam int employeeNo) {
//    return attendanceService.getAttendanceRecord(employeeNo);
//  }
  
}
