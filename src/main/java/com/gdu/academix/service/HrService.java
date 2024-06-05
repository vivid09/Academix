package com.gdu.academix.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import jakarta.servlet.http.HttpServletRequest;

public interface HrService {

	int registerEmployee(MultipartHttpServletRequest mulrequest, MultipartRequest multipartRequest);
	
}
