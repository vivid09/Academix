package com.gdu.academix.listener;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.gdu.academix.mapper.UserMapper;

/*
  web.xml 파일에 <listener> 태그를 등록해야 한다.
  <listener>
    <listener-class>com.gdu.academix.listener.MyHttpSessionListener</listener-class>
  </listener>
*/

public class MyHttpSessionListener implements HttpSessionListener {

  // 세션 만료 시 자동으로 동작
  @Override
  public void sessionDestroyed(HttpSessionEvent se) {
    
    // HttpSession
    HttpSession session = se.getSession();
    
    // ApplicationContext
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
    
    // session_id
    String sessionId = session.getId();
    
    // getBean()
    // Service 를 추천하나, Mapper 도 가능
    UserMapper userMapper = ctx.getBean("userMapper", UserMapper.class);
    
    // updateAccessHistory()
    userMapper.updateAccessHistory(sessionId);
    
    // 확인 메시지
    System.out.println(sessionId + " 세션 정보가 소멸되었습니다.");
    
  }
  
}
