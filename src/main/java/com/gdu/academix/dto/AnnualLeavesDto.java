package com.gdu.academix.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AnnualLeavesDto {
  private int leaveNo, year, remainLeaves, usedLeaves, totalLeaves, employeeNo;
}
