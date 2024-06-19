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
public class AttendanceAdjustmentRequestDto {
  private RequestsDto requests;
  private Timestamp adjustmentDate, timeIn, timeOut;
  private RequestAttachDto attach;
  
}
