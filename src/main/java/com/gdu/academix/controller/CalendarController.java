package com.gdu.academix.controller;

import java.text.ParseException;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.academix.service.CalendarService;

@RequestMapping("/calendar")
@Controller
public class CalendarController {

		
  private final CalendarService calendearService;
	
  public CalendarController(CalendarService calendearService) { 
  	super();
  	this.calendearService = calendearService; 
  }
		
	
  
  @GetMapping("/calendar.page")
  public String calendarPage() {
    return "calendar/calendar";
  }
  
  @PostMapping(value="/registerEvent.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> registerEvent(@RequestBody Map<String, Object> params) throws ParseException {
    int insertCount = calendearService.registerEvent(params);
    return ResponseEntity.ok(Map.of("insertResult", insertCount == 1 ? "일정이 등록되었습니다." : "일정이 등록되지 않았습니다."));
  }
  
  @PostMapping(value="/updateEvent.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> updateEvent(@RequestBody Map<String, Object> params) throws ParseException {
  	int insertCount = calendearService.updateEvent(params);
    return ResponseEntity.ok(Map.of("insertResult", insertCount == 1 ? "일정이 수정되었습니다." : "일정이 수정되지 않았습니다."));
  }
  
  @PostMapping(value="/removeEvent.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> removeEvent(@RequestBody int eventNo) {
    int removeCount = calendearService.removeEvent(eventNo);
    return ResponseEntity.ok(Map.of("removeCount", removeCount == 1 ? "일정이 삭제되었습니다." : "일정이 삭제되지 않았습니다."));
  }
  
  @GetMapping(value="/getEvents.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getEventList(@RequestParam int ownerNo) {
    return calendearService.getEventList(ownerNo);
  }
  
}
