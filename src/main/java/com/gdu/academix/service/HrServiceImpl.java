package com.gdu.academix.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.AnnualLeavesDto;
import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.RanksDto;
import com.gdu.academix.mapper.HrMapper;
import com.gdu.academix.mapper.UserMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private  HrMapper hrMapper;
	@Autowired
	private MyFileUtils myFileUtils;
	@Autowired
	private MyPageUtils myPageUtils;
	@Autowired
	private UserMapper userMapper;
	
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
	public ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params) {
		boolean enableEmail = userMapper.getUserByMap(params) == null;
		    return new ResponseEntity<>(Map.of("enableEmail", enableEmail)
		        , HttpStatus.OK);
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
		
		String profilePicturePath;
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String pw;
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

	    

		
		RanksDto ranks = RanksDto.builder()
							  	 .rankNo(rankNo)
				                 .rankTitle(rankTitle)
				                 .build();
		DepartmentsDto depart = DepartmentsDto.builder()
				                             .departmentNo(departmentNo)
				                             .departName(departName)
				                             .build();
		
		EmployeesDto employees = EmployeesDto.builder()
				                             .employeeNo(employeeNo)
				                             .name(name)
				                             .email(email)
				                             .phone(phone)
				                             .address(address)
				                             .depart(depart)
				                             .rank(ranks)
				                             .employeeStatus(employeeStatus)
				                             .hireDate(sqlHireDate)
				                             .exitDate(sqlExitDate)
				                             .build();
	   
		 if (multipartRequest.getFile("profile") != null && !multipartRequest.getFile("profile").isEmpty()) {
		        // 파일이 존재하고, 비어있지 않을 경우에만 프로필 사진 경로를 업데이트합니다.
		        profilePicturePath = myFileUtils.updateProfilePicture(multipartRequest, "profile");
		        employees.setProfilePicturePath(profilePicturePath);
			} 
		    
		   
		if(multipartRequest.getParameter("pw") != null && !multipartRequest.getParameter("pw").equals("")) {
			pw = MySecurityUtils.getSha256(multipartRequest.getParameter("pw"));
			employees.setPassword(pw);
		}
		
		
		int modifyCount = hrMapper.employeeModify(employees);
		System.out.println(employees);
		return modifyCount;
		
	}
	
	@Override
	@Scheduled(cron = "0 0 0 * * *") // 매일 정각에 실행
	public void grantAnnualLeave() {
		List<EmployeesDto> employees = null;
        try {
            employees = hrMapper.getAllEmployees();
        } catch (Exception e) {
            
            return;
        }
        java.util.Date now = new java.util.Date();
        Calendar currentCal = Calendar.getInstance();
        currentCal.setTime(now);
        int currentYear = currentCal.get(Calendar.YEAR);
        for (EmployeesDto employee : employees) {
            try {
            	Calendar hireCal = Calendar.getInstance();
                hireCal.setTime(employee.getHireDate());
                int hireYear = hireCal.get(Calendar.YEAR);
                int yearsOfService = currentYear - hireYear;

                int annualLeaveDays = (yearsOfService >= 2) ? 15 : 12;
                annualLeaves(employee.getEmployeeNo(), annualLeaveDays, yearsOfService);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
		
	 }
  
	@Override
	@Transactional
	public void annualLeaves(int employeeNo, int annualLeaveDays, int yearsOfService) {
		try {
	        // 직원의 연차 정보를 직원 번호로 조회합니다.
	        AnnualLeavesDto existingLeave = hrMapper.getAnnualLeavesByEmployeeNo(employeeNo);
	        
	        if (existingLeave != null) {
	            // 기존 연차 정보가 있는 경우, 기존 totalLeaves 값에 추가하여 업데이트합니다.
	            int updatedLeaves = existingLeave.getTotalLeaves() + annualLeaveDays;
	            existingLeave.setTotalLeaves(updatedLeaves);
	            hrMapper.updateAnnualLeaves(existingLeave);
	        } else {
	            // 기존 연차 정보가 없는 경우, 새로운 연차 정보를 생성하여 추가합니다.
	            AnnualLeavesDto newLeave = new AnnualLeavesDto();
	            newLeave.setEmployeeNo(employeeNo);
	            newLeave.setTotalLeaves(annualLeaveDays);
	            // 연차 정보에 근속 연수 설정은 필요시에만 추가합니다.
	            newLeave.setYear(yearsOfService);
	            hrMapper.insertAnnualLeaves(newLeave);
	        }
	    } catch (Exception e) {
	        // 예외가 발생한 경우 예외를 출력합니다.
	        e.printStackTrace();
	    }
    }
	
	@Override
	@Transactional
	public int removeEmoloyee(int employeeNo) {
		int deleteCount = hrMapper.removeAnnualEmployeeNo(employeeNo);
		deleteCount += hrMapper.removeEmployee(employeeNo);
		return  deleteCount;
	}
	
}
