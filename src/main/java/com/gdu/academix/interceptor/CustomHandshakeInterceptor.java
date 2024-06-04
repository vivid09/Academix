package com.gdu.academix.interceptor;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.gdu.academix.dto.EmployeesDto;

import jakarta.servlet.http.HttpSession;

public class CustomHandshakeInterceptor implements HandshakeInterceptor {
  
  @Override
  public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
      Map<String, Object> attributes) throws Exception {
    HttpSession httpSession = getSession(request); // HttpSession 가져옴.
    if(httpSession != null) {
      EmployeesDto user = (EmployeesDto) httpSession.getAttribute("user"); // HttpSession에서 사용자 정보 가져옴.
      if(user != null) {
        attributes.put("user", user); // WebSocketSession의 attributes에 사용자 정보 저장.
      }
    }
    return true;
  }
  

  @Override
  public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
      Exception exception) {
    // TODO Auto-generated method stub
    
  }
  
  
  // ServletHttpRequest에서 HttpSession 추출
  // WebSocket 핸드셰이크 요청이 들어왔을 때 이 메소드를 통해 HttpSession에 저장된 정보를 가져올 수 있음
  private HttpSession getSession(ServerHttpRequest request) {
    // request객체가 ServletServerHttpRequest의 인스턴스인가?
    // 다시 말해서 WebSocket 요청이 서블릿 기반의 HTTP 요청인지
    if(request instanceof ServletServerHttpRequest) { 

      // request가 ServletServerHttpRequest의 인스턴스인 경우, 이를 ServletServerHttpRequest로 캐스팅
      ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
      
      // HttpServletRequest 추출.. -> getServletRequest() 사용
      // getSession(false)는 현재 요청과 연결된 세션이 있으면 이를 반환하고, 
      // 없으면 null을 반환. 이는 새로운 세션을 생성하지 않기 위해서
      return servletRequest.getServletRequest().getSession(false);
    }
    return null;
  }
  
  /*
   * ServerHtpRequest
   * - webSocket 핸드셰이크 요청이 들어왔을 때 spring에서 이를 ServerHttpRequest라고 표현.
   * - Http 요청을 추상화한 인터페이스.
   * 
   * ServletServerHttpRequest
   * - ServerHTtpRequest의 구체적인 구현 클래스 중 하나. Servlet 기반의 HTTP 요청 나타냄.
   * - Servlet 요청(HttpServletRequest)를 감쌈.
   * 
   * HttpSession
   * - HTTP 세션은 클라이언트와 서버 간의 상태 유지
   * 
   */
  
  
  
  

}
