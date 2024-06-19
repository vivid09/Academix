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
public class BlogDto {
  private int notiPostNo, authorNo;
  private String title, content;
  private Timestamp postDate;
  private EmployeesDto employee;
}
