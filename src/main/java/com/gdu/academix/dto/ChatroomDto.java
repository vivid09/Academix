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
public class ChatroomDto {

  int chatroomNo, creatorNo, participantCount;
  String chatroomTitle, chatroomType;
  Timestamp chatroomCreatedDate;
}