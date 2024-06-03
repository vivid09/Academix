package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;

public interface FolderService {
	
  ResponseEntity<Map<String, Object>> checkDrive(int employeeNo);

}
