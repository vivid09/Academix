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
public class AttendanceRecordDto {
  private int recordNo, employeeNo, status;
  private Timestamp recordDate, timeIn, timeOut;
}
