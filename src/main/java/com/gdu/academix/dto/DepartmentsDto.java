package com.gdu.academix.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class DepartmentsDto {

  private int departmentNo, parentDepartNo ;
  private String departName;

}
