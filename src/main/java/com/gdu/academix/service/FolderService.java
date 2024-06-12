package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface FolderService {
	
  ResponseEntity<Map<String, Object>> checkDrive(int employeeNo);
  int createDrive(Map<String, Object> params);
  
  ResponseEntity<Map<String, Object>> getFileList();
  
  boolean registerUpload(MultipartHttpServletRequest multipartRequest);
  int addFolder(Map<String, Object> params);
  void loadUploadList(Model model);

}
