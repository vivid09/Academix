package com.gdu.academix.service;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.UploadDto;

public interface UploadService {
  boolean registerUpload(MultipartHttpServletRequest multipartRequest);
  void loadUploadList(Model model);
  void loadUploadByNo(int uploadNo, Model model);
  ResponseEntity<Resource> download(HttpServletRequest request);
  ResponseEntity<Resource> downloadAll(HttpServletRequest request);
  void removeTempFiles();
  UploadDto getUploadByNo(int uploadNo);
  int modifyUpload(UploadDto upload);
  ResponseEntity<Map<String, Object>> getAttachList(int uploadNo);
  ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception;
  ResponseEntity<Map<String, Object>> removeAttach(int attachNo);
  int removeUpload(int uploadNo);
}
