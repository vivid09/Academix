package com.gdu.academix.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.gdu.academix.interceptor.CustomHandshakeHanlder;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

  @Override
  public void configureMessageBroker(MessageBrokerRegistry registry) {
    // 메시지 브로커를 설정해서 특정 경로로 메시지 보낼 수 있게 함.
    registry.enableSimpleBroker("/topic", "/queue");

    
    
    // 클라이언트가 연결할 수 있는 WebSocket 엔드포인트 설정
 // 예를 들어 /topic/hello라는 토픽에 대해 구독 신청 -> 실제 경로는 /app/topic/hello
    registry.setApplicationDestinationPrefixes("/send");
    registry.setUserDestinationPrefix("/user");
  }
  
  
  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    registry.addEndpoint("/ws-stomp")
            .setHandshakeHandler(new CustomHandshakeHanlder())
            .setAllowedOriginPatterns("*")
            .withSockJS();
  }
  
  //.addInterceptors(new HttpSessionHandshakeInterceptor())
  //.setHandshakeHandler(new CustomHandshakeHanlder())
  //
  // /topic : 한명이 message 발행 시 해당 토픽 구독하는 n명에게 다시 보냄.
  // /queue : 한명이 message 발행 시 발행한 한명에게 다시 정보를 보냄.
  
  //.addInterceptors(new CustomHandshakeInterceptor())
  

}
