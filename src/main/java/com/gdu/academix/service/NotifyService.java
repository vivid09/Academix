package com.gdu.academix.service;

import java.util.List;

import com.gdu.academix.dto.NotificationsDto;

public interface NotifyService {
  
  int insertNotification(NotificationsDto notification);
  List<NotificationsDto> getNotificationList(int employeeNo);

}
