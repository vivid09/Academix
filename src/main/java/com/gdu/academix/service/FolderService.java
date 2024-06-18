package com.gdu.academix.service;

import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletRequest;

public interface FolderService {
	
  ResponseEntity<Map<String, Object>> checkDrive(int employeeNo);
  int createDrive(Map<String, Object> params);
  
  ResponseEntity<Map<String, Object>> getFileList();
  
  boolean registerUpload(MultipartHttpServletRequest multipartRequest);
  int addFolder(Map<String, Object> params);
  
  void loadUploadList(Model model);
  
  ResponseEntity<Resource> download(HttpServletRequest request);
  void removeTempFiles();
  
  ResponseEntity<Map<String, Object>> removeFile(HttpServletRequest request);

}
