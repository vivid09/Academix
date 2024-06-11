package com.gdu.academix.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class NotificationsDto {

  int notificationNo, seenStatus, employeeNo, chatroomNo, notifierNo;
  String message, notificationType, notifierName;
  Timestamp notificationDate;
  //EmployeesDto notifier;
  
}
