package com.gdu.academix.service;

import java.text.ParseException;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.CourseDto;

public interface CoursesService {
  boolean registerCourse(MultipartHttpServletRequest multipartRequest) throws Exception;
  ResponseEntity<Map<String, Object>> loadCourseList(HttpServletRequest request);
  CourseDto getCourseByNo(int uploadNo);
  int modifyCourse(CourseDto course);
  int removeCourse(int uploadNo);
}
