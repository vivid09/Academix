package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestsDto;

import jakarta.servlet.http.HttpServletRequest;

public interface RequestsService {

 
  int createLeaveRequest(MultipartHttpServletRequest multipartRequest);
  void prepareRequestsList(HttpServletRequest request, Model model);
  LeaveRequestDto getRequestsbyNo(int requestNo);
  int requestApproval(HttpServletRequest request);
  int requestReject(HttpServletRequest request);
  void getRequestsList(Model model);
  int modifyRequest(MultipartHttpServletRequest multipartRequest);
  int removeRequest(int requestNo);
}
