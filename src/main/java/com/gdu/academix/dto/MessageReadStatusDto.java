package com.gdu.academix.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MessageReadStatusDto {

  int messageStatusNo, messageNo, chatroomNo, employeeNo, unreadCount;
  String isRead;
  
}
