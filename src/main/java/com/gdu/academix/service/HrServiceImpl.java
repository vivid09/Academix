package com.gdu.academix.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.gdu.academix.dto.AnnualLeavesDto;
import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.RanksDto;
import com.gdu.academix.mapper.HrMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.xml.ws.Response;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private  HrMapper hrMapper;
	@Autowired
	private MyFileUtils myFileUtils;
	@Autowired
	private MyPageUtils myPageUtils;
	
	@Transactional
	@Override
	public int registerEmployee(MultipartHttpServletRequest multipartRequest) {
		String profilePicturePath = myFileUtils.updateProfilePicture(multipartRequest, "profile");
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String pw =  MySecurityUtils.getSha256(multipartRequest.getParameter("pw"));
		String phone = multipartRequest.getParameter("phone");
		String address = multipartRequest.getParameter("address");
		int employeeStatus = Integer.parseInt(multipartRequest.getParameter("employeeStatus"));
		int departmentNo = Integer.parseInt(multipartRequest.getParameter("departmentNo"));
		int rankNo = Integer.parseInt(multipartRequest.getParameter("rankNo"));

		String startDateString = multipartRequest.getParameter("hireDate");
	    String endDateString = multipartRequest.getParameter("exitDate");

	    LocalDate hireDate = null;
	    LocalDate exitDate = null;

	    if (startDateString != null && !startDateString.trim().isEmpty()) {
	        hireDate = LocalDate.parse(startDateString);
	    }

	    if (endDateString != null && !endDateString.trim().isEmpty()) {
	        exitDate = LocalDate.parse(endDateString);
	    }

	    // LocalDate를 SQL Date로 변환
	    Date sqlHireDate = (hireDate != null) ? Date.valueOf(hireDate) : null;
	    Date sqlExitDate = (exitDate != null) ? Date.valueOf(exitDate) : null;

		
		/*
		 * String parentDepartNoStr = multipartRequest.getParameter("parentDepartNo");
		 * Integer parentDepartNo = null; if (parentDepartNoStr != null &&
		 * !parentDepartNoStr.trim().isEmpty()) { parentDepartNo =
		 * Integer.parseInt(parentDepartNoStr); }
		 */
		
		RanksDto ranks = RanksDto.builder()
							  	 .rankNo(rankNo)
				                 .build();
		DepartmentsDto depart = DepartmentsDto.builder()
				                             .departmentNo(departmentNo)
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
				                             .exitDate(sqlExitDate)
				                             .build();
	   
		int insertCount = hrMapper.registerEmployee(employees);
		return insertCount;
	}

	@Override
	public ResponseEntity<Map<String, Object>> getEmployeeList(HttpServletRequest request) {
		
		
		  
		  
		  
		  // 페이징 처리에 필요한 정보 처리 myPageUtils.setPaging(total, display, page);
		 
	 		
	 		// DB 로 보낼 Map 생성
	 		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
	 				                         , "end", myPageUtils.getEnd());
		
		//System.out.println(hrMapper.getEmployeesList(map));
		return new ResponseEntity<>(Map.of("employeesList",hrMapper.getEmployeesList(map)), HttpStatus.OK);
	}
	
	@Override
	public EmployeesDto getUserProfileByNo(int employeeNo) {
		
		return hrMapper.getUserProfileByNo(employeeNo);
	}
	

	@Override
	public int emloyeeModify(MultipartHttpServletRequest multipartRequest) {
		
		String profilePicturePath = myFileUtils.updateProfilePicture(multipartRequest, "profile");
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String pw =  MySecurityUtils.getSha256(multipartRequest.getParameter("pw"));
		String phone = multipartRequest.getParameter("phone");
		String address = multipartRequest.getParameter("address");
		String departName = multipartRequest.getParameter("departName");
		String rankTitle = multipartRequest.getParameter("rankTitle");
		int employeeStatus = Integer.parseInt(multipartRequest.getParameter("employeeStatus"));
		int departmentNo = Integer.parseInt(multipartRequest.getParameter("departmentNo"));
		int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
		int rankNo = Integer.parseInt(multipartRequest.getParameter("rankNo"));

		String startDateString = multipartRequest.getParameter("hireDate");
	    String endDateString = multipartRequest.getParameter("exitDate");

	    LocalDate hireDate = null;
	    LocalDate exitDate = null;

	    if (startDateString != null && !startDateString.trim().isEmpty()) {
	        hireDate = LocalDate.parse(startDateString);
	    }

	    if (endDateString != null && !endDateString.trim().isEmpty()) {
	        exitDate = LocalDate.parse(endDateString);
	    }

	    // LocalDate를 SQL Date로 변환
	    Date sqlHireDate = (hireDate != null) ? Date.valueOf(hireDate) : null;
	    Date sqlExitDate = (exitDate != null) ? Date.valueOf(exitDate) : null;

		int parentDepartNo = Integer.parseInt(multipartRequest.getParameter("parentDepartNo"));
		
		
		
		RanksDto ranks = RanksDto.builder()
							  	 .rankNo(rankNo)
				                 .rankTitle(rankTitle)
				                 .build();
		DepartmentsDto depart = DepartmentsDto.builder()
				                             .departmentNo(departmentNo)
				                             .departName(departName)
				                             .parentDepartNo(parentDepartNo)
				                             .build();
		
		EmployeesDto employees = EmployeesDto.builder()
				                             .profilePicturePath(profilePicturePath)
				                             .employeeNo(employeeNo)
				                             .name(name)
				                             .email(email)
				                             .password(pw)
				                             .phone(phone)
				                             .address(address)
				                             .depart(depart)
				                             .rank(ranks)
				                             .employeeStatus(employeeStatus)
				                             .hireDate(sqlHireDate)
				                             .exitDate(sqlExitDate)
				                             .build();
	   
		int modifyCount = hrMapper.employeeModify(employees);
		System.out.println(employees);
		return modifyCount;
		
	}
	
	@Override
	public void annualLeaves() {
		int leaveDay = 1;
		
		
		AnnualLeavesDto annualLeaves = AnnualLeavesDto.builder()
				                                      .build();
		
	}
	
}
