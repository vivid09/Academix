package com.gdu.academix.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ChatroomParticipateDto {
  private int chatroomParticipateNo, participantNo;
  private int chatroomNo;
}
