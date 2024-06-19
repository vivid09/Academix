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
public class CourseDto {
  private int courseNo;
  private String title, description, coursePlan;
  private Timestamp startDate, endDate;
  private int courseState;
  private EmployeesDto employee;
}
