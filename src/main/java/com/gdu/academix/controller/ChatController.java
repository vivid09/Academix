package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.academix.service.BlogService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/chatting")
@RequiredArgsConstructor
@Controller
public class ChatController {
	
	@GetMapping("/chat.page")
	public String chat() {
		return "chatting/chat";
	}

}
