package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AttachDto;
import com.gdu.academix.dto.CourseDto;
import com.gdu.academix.dto.UploadDto;

@Mapper
public interface CourseMapper {
  int insertCourse(CourseDto Course);
  int getCourseCount();
  List<CourseDto> getCourseList(Map<String, Object> map);
  CourseDto getCourseByNo(int courseNo);
  int updateCourse(CourseDto Course);
  int deleteCourse(int courseNo);
}
