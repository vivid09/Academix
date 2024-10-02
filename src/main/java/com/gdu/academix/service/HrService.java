package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.EmployeesDto;

import jakarta.servlet.http.HttpServletRequest;

public interface HrService {

	int registerEmployee(MultipartHttpServletRequest multipartRequest);
	ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
	ResponseEntity<Map<String, Object>> getEmployeeList(HttpServletRequest request);
	EmployeesDto getUserProfileByNo(int employeeNo);
	int emloyeeModify(MultipartHttpServletRequest multipartRequest);
	int removeEmoloyee(int employeeNo);
	void annualLeaves(int employeeNo, int annualLeaveDays, int yearsOfService);
	void grantAnnualLeave();
	
}
