package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface FolderService {
	
  ResponseEntity<Map<String, Object>> checkDrive(int employeeNo);
  int createDrive(Map<String, Object> params);
  int registerUpload(MultipartHttpServletRequest multipartRequest);
  int createFolder(Map<String, Object> params);

}
