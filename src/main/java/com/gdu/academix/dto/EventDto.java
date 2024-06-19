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
public class EventDto {
  private int eventNo, ownerNo;
  private String title, backgroundColor, textColor, location, description, lat, lng;
  private Timestamp start, end;
  private boolean allDay;
}
