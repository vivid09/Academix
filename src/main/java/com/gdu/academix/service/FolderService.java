package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;

import jakarta.servlet.http.HttpServletRequest;

public interface FolderService {
	
  ResponseEntity<Map<String, Object>> checkDrive(int employeeNo);
  int createFolder(HttpServletRequest request);

}
