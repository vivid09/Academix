package com.gdu.academix.dto;

import java.sql.Timestamp;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data 
@Builder
public class ReportDto {
  private int reportNo, postNo, authorNo, reportCategory;
  private String description;
  private Timestamp reportDate;
  private EmployeesDto employee;
  private AnonDto anon;
}
