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
  private int employeeNo, employeeStatus;
  private String name, email, phone, address, password, profilePicturePath;
  private Date hireDate, exitDate;
  private DepartmentsDto depart;
  private RanksDto rank;
}

