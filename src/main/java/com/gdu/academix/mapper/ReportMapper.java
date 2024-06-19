package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.ReportDto;

@Mapper
public interface ReportMapper {
  int insertReport(ReportDto  report);
  int getReportCount();
  List<ReportDto> getReportList(Map<String, Object> map);
  ReportDto getReportByNo(int reportNo);
//  int updateReport(ReportDto report);
  int deleteReport(int reportNo);
  
}
