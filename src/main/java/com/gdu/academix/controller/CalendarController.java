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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.CalendarService;

import jakarta.servlet.http.HttpServletRequest;

@RequestMapping("/calendar")
@Controller
public class CalendarController {

		
  private final CalendarService calendearService;
	
  public CalendarController(CalendarService calendearService) { 
  	super();
  	this.calendearService = calendearService; 
  }
		
	
  
  @GetMapping("")
  public String calendarPage() {
    return "calendar/calendar";
  }
  
  @PostMapping(value="/registerEvent.do", produces="application/json")
  public String registerEvent(@RequestBody Map<String, Object> params, RedirectAttributes redirectAttributes) throws ParseException {
    int insertCount = calendearService.registerEvent(params);
    redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "블로그가 등록되었습니다." : "블로그가 등록되지 않았습니다.");
    return "redirect:/calendar/calendar";
  }
  
  @PostMapping(value="/updateEvent.do", produces="application/json")
  public String updateEvent(@RequestBody Map<String, Object> params, RedirectAttributes redirectAttributes) throws ParseException {
  	int insertCount = calendearService.updateEvent(params);
  	redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "블로그가 등록되었습니다." : "블로그가 등록되지 않았습니다.");
  	return "redirect:/calendar/calendar";
  }
  
  @PostMapping(value="/removeEvent.do", produces="application/json")
  public String removeEvent(@RequestBody int eventNo
                         , RedirectAttributes redirectAttributes) {
    int removeCount = calendearService.removeEvent(eventNo);
    redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "블로그가 삭제되었습니다." : "블로그가 삭제되지 않았습니다.");
  	return "redirect:/calendar/calendar";
  }
  
  @GetMapping(value="/getEvents.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getEventList(HttpServletRequest request) {
    return calendearService.getEventList(request);
  }
  
}
