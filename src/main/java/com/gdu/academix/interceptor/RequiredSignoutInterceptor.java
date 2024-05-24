package com.gdu.academix.interceptor;

import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class RequiredSignoutInterceptor implements HandlerInterceptor {

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  
    HttpSession session = request.getSession();
    if(session.getAttribute("user") != null) {
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      out.println("alert('해당 기능은 사용할 수 없습니다.');");
      out.println("history.back();");
      out.println("</script>");
      out.flush();
      out.close();
      return false;
    }
    
    return true;
    
  }
  
}
