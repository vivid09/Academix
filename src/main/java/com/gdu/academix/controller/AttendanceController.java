package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.academix.service.AttendanceService;

@RequestMapping("/attendance")
@Controller
public class AttendanceController {

		
  private final AttendanceService attendanceService;
	
  public AttendanceController(AttendanceService attendanceService) { 
  	super();
  	this.attendanceService = attendanceService; 
  }
		
  @GetMapping("/commute")
  public String commutePage() {
    return "attendance/commute";
  }
  
//  
//  @PostMapping(value="/registerEvent.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> registerEvent(@RequestBody Map<String, Object> params, RedirectAttributes redirectAttributes) throws ParseException {
//    int insertCount = calendearService.registerEvent(params);
//    return ResponseEntity.ok(Map.of("insertResult", insertCount == 1 ? "일정이 등록되었습니다." : "일정이 등록되지 않았습니다."));
//  }
//  
//  @PostMapping(value="/updateEvent.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> updateEvent(@RequestBody Map<String, Object> params, RedirectAttributes redirectAttributes) throws ParseException {
//  	int insertCount = calendearService.updateEvent(params);
//    return ResponseEntity.ok(Map.of("insertResult", insertCount == 1 ? "일정이 수정되었습니다." : "일정이 수정되지 않았습니다."));
//  }
//  
//  @PostMapping(value="/removeEvent.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> removeEvent(@RequestBody int eventNo, RedirectAttributes redirectAttributes) {
//    int removeCount = calendearService.removeEvent(eventNo);
//    return ResponseEntity.ok(Map.of("removeCount", removeCount == 1 ? "일정이 삭제되었습니다." : "일정이 삭제되지 않았습니다."));
//  }
//  
//  @GetMapping(value="/getEvents.do", produces="application/json")
//  public ResponseEntity<Map<String, Object>> getEventList(HttpServletRequest request) {
//    return calendearService.getEventList(request);
//  }
//  
}
