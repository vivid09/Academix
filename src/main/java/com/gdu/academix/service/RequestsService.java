package com.gdu.academix.service;

import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestsDto;

import jakarta.servlet.http.HttpServletRequest;

public interface RequestsService {

 
  boolean createLeaveRequest(MultipartHttpServletRequest multipartRequest);
  void prepareRequestsList(HttpServletRequest request, Model model);
  LeaveRequestDto getRequestsbyNo(int requestNo);
  int requestApproval(HttpServletRequest request);
  int requestreject(HttpServletRequest request);
  void getRequestsList(HttpServletRequest request,Model model);
  ResponseEntity<Map<String, Object>> getLeaveRequestListByEmployeeNo(HttpServletRequest request);
  int modifyRequest(MultipartHttpServletRequest multipartRequest);
  int removeRequest(int requestNo);
  ResponseEntity<Map<String, Object>> pending();
  ResponseEntity<Resource> download(HttpServletRequest request);
}
