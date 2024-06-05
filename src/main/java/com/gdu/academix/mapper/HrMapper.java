package com.gdu.academix.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.RanksDto;

@Mapper
public interface HrMapper {

	int registerEmployee(EmployeesDto employees);
	int registerDepartment(DepartmentsDto depart);
	int registerRank(RanksDto ranks);
	
}
