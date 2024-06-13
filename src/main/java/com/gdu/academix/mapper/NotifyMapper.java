package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.NotificationsDto;

@Mapper
public interface NotifyMapper {
  
  int insertNotification(NotificationsDto notification);
  List<NotificationsDto> getNotificationList(int employeeNo, int seenStatus);
  int updateSeenStatus(List<Integer> notificationNoList);
  int updateChatroomSeenStatus(Map<String, Object> map);
  
}
