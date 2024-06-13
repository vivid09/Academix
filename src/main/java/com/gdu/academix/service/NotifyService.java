package com.gdu.academix.service;

import java.util.List;
import java.util.Map;

import com.gdu.academix.dto.NotificationsDto;

public interface NotifyService {
  
  int insertNotification(NotificationsDto notification);
  List<NotificationsDto> getNotificationList(int employeeNo);
  int updateSeenStatus(List<Integer> notificationNoList);
  int updateChatroomSeenStatus(Map<String, Object> map);

}
