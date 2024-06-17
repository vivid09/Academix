package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gdu.academix.dto.AnnualLeavesDto;
import com.gdu.academix.dto.EmployeesDto;

@Mapper
public interface HrMapper {

	int registerEmployee(EmployeesDto employees);
	List<EmployeesDto> getEmployeesList(Map<String, Object> map);
	int getEmployeeListCount();
    EmployeesDto getUserProfileByNo(int employeeNo);
    int employeeModify(EmployeesDto employees);
    void insertAnnualLeaves(AnnualLeavesDto annualLeaves);
    int removeEmployee(int employeeNo);
    int removeAnnualEmployeeNo(int employeeNo);
    List<EmployeesDto> getAllEmployees();
    AnnualLeavesDto getAnnualLeavesByEmployeeNo(int employeeNo);
    void updateAnnualLeaves(AnnualLeavesDto annualLeaves);
    
	
}
