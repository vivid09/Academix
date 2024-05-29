package com.gdu.academix.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class EmployeesDto {
	int employeeNo, employeeStatus;
	String name, email, phone, address, password, profilePicturPath;
	Date hireDate, exitDate;
	DepartmentsDto depart;
	RanksDto rank;

}
