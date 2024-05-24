package com.gdu.academix.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gdu.academix.interceptor.RequiredSigninInterceptor;
import com.gdu.academix.interceptor.RequiredSignoutInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	private final RequiredSigninInterceptor requiredSigninInterceptor;
	private final RequiredSignoutInterceptor requiredSignoutInterceptor;
	public WebMvcConfig(RequiredSigninInterceptor requiredSigninInterceptor,
	                      RequiredSignoutInterceptor requiredSignoutInterceptor) {
	    this.requiredSigninInterceptor = requiredSigninInterceptor;
	    this.requiredSignoutInterceptor = requiredSignoutInterceptor;
	}
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/resources/**")
         .addResourceLocations("classpath:/static/");
	    registry.addResourceHandler("/upload/**")
         .addResourceLocations("file:///upload/");
	    registry.addResourceHandler("/blog/**")
         .addResourceLocations("file:///blog/");
	}
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
      registry.addInterceptor(requiredSigninInterceptor)
        .addPathPatterns
     ("/bbs/write.page", "/blog/write.page", "/upload/write.page", "/blog/editBlog.do");
      registry.addInterceptor(requiredSignoutInterceptor)
        .addPathPatterns("/user/signin.page", "/user/signup.page");
    }
}