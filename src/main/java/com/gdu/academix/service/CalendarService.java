package com.gdu.academix.service;

import java.text.ParseException;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import jakarta.servlet.http.HttpServletRequest;

public interface CalendarService {
	
  int registerEvent(Map<String, Object> params) throws ParseException;
  ResponseEntity<Map<String, Object>> getEventList(HttpServletRequest request);
  int updateEvent(Map<String, Object> params) throws ParseException;;
  int removeEvent(int eventNo);
}
