package com.gdu.academix.service;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.academix.dto.ReportDto;

public interface ReportService {
  ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
  int registerReport(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> getReportList(HttpServletRequest request);
  ReportDto getReportByNo(int reportNo);
  List<String> getEditorImageList(String content);
//  int modifyReport(HttpServletRequest request);
  int removeReport(int reportNo);
  
  
  
}
