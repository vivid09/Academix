package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.gdu.academix.dto.AnnualLeavesDto;
import com.gdu.academix.dto.EmployeesDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.xml.ws.Response;

public interface HrService {

	int registerEmployee(MultipartHttpServletRequest multipartRequest);
	ResponseEntity<Map<String, Object>> getEmployeeList(HttpServletRequest request);
	EmployeesDto getUserProfileByNo(int employeeNo);
	int emloyeeModify(MultipartHttpServletRequest multipartRequest);
	void annualLeaves();
}
