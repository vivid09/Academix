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
public class AnonDto {
  private int postNo, authorNo, hit, status;
  private String title, content;
  private Timestamp postDate;
  private EmployeesDto employee;
}
