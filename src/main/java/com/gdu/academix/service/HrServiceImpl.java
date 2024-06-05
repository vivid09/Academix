package com.gdu.academix.service;

import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.RanksDto;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private MyFileUtils myFileUtils;
	
	@Override
	public int registerEmployee(MultipartHttpServletRequest multipartRequest, MultipartRequest mulrequest) {
		String profilePicturePath = myFileUtils.updateProfilePicture(multipartRequest, "mainProfilePicturePath");
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String pw =  MySecurityUtils.getSha256(multipartRequest.getParameter("pw"));
		String phone = multipartRequest.getParameter("phone");
		String address = multipartRequest.getParameter("address");
		String departName = multipartRequest.getParameter("departName");
		String rankTitle = multipartRequest.getParameter("rankTitle");
		int employeeStatus = Integer.parseInt(multipartRequest.getParameter("employeeStatus"));

		String startDateString = multipartRequest.getParameter("hireDate");
	    String endDateString = multipartRequest.getParameter("exitDate");
	    int leaveType = Integer.parseInt(multipartRequest.getParameter("leaveType"));

	    LocalDate hireDate = LocalDate.parse(startDateString);
	    LocalDate exitDate = LocalDate.parse(endDateString);

	    // LocalDate를 SQL Date로 변환
	    Date sqlHireDate = Date.valueOf(hireDate);
	    Date sqlEndDate = Date.valueOf(exitDate);

		int parentDepartNo = Integer.parseInt(multipartRequest.getParameter("parentDepartNo"));
		
		RanksDto ranks = RanksDto.builder()
				                 .rankTitle(rankTitle)
				                 .build();
		DepartmentsDto depart = DepartmentsDto.builder()
				                             .departName(departName)
				                             .parentDepartNo(parentDepartNo)
				                             .build();
		
		EmployeesDto employees = EmployeesDto.builder()
				                             .profilePicturePath(profilePicturePath)
				                             .name(name)
				                             .email(email)
				                             .password(pw)
				                             .phone(phone)
				                             .address(address)
				                             .depart(depart)
				                             .rank(ranks)
				                             .employeeStatus(employeeStatus)
				                             .hireDate(sqlHireDate)
				                             .exitDate(sqlEndDate)
				                             .build();
	   
		
		return 0;
	}

}
