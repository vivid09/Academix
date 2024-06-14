package com.gdu.academix.service;

import java.text.ParseException;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import jakarta.servlet.http.HttpServletRequest;

public interface AttendanceService {
	
  int registerAttendanceRecord(Map<String, Object> params) throws ParseException;
  ResponseEntity<Map<String, Object>> getAttendanceRecord(int employeeNo);
  int updateAttendanceRecord(Map<String, Object> params) throws ParseException;;
  int removeAttendanceRecord(int recordNo);
}
