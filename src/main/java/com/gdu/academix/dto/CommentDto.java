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
public class CommentDto {
  private int commentNo, commentStatus, postNo, authorNo, notiPostNo, depth, groupNo;
  private String content;
  private Timestamp commentDate;
  private EmployeesDto employee;
  private BlogDto blog;
}
